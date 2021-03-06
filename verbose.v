module verbose

// verbose is a generator for random parts of speech
import os
import rand

struct Dictionary {
mut:
	adjective []string
	adverb    []string
	noun      []string
	verb      []string
}

const (
	dictionary = &Dictionary{}
)

// init loads up the word lists from ./data/en/*.txt
// eventually when $embed_file('path') is ready we can use that.
fn init() {
	// Thanks to `!! ryan` on vlang discord for the initialization approach.
	mut d := &Dictionary(dictionary)
	// Why an env var? Because if this module is not in the compilation path
	// it won't be able to locate the relative data directory, you will
	// have to supply it explicitly. End slash and all!
	// Again, $embed_file('path') will remove these requirements.
	mut path := os.getenv('VERBOSE_DATA_PATH')
	if path == '' {
		path = os.join_path(os.dir(@FILE), 'data', 'en')
	} else {
		println('verbose using env data path: $path')
	}
	if !path.ends_with(os.path_separator) {
		path += os.path_separator
	}
	// TODO: Is there an effective way to loop on this?
	println('reading dictionary files from $path')
	adjectives := os.read_file(path + 'adjectives.txt') or {
		println('could not read adjectives')
		println(err)
		return
	}
	d.adjective << adjectives.trim_right('\n').split('\n')
	adverbs := os.read_file(path + 'adverbs.txt') or {
		println('could not read adverbs')
		return
	}
	d.adverb << adverbs.trim_right('\n').split('\n')
	nouns := os.read_file(path + 'nouns.txt') or {
		println('could not read nouns')
		return
	}
	d.noun << nouns.trim_right('\n').split('\n')
	verbs := os.read_file(path + 'verbs.txt') or {
		println('could not read verbs')
		return
	}
	d.verb << verbs.trim_right('\n').split('\n')
	println('-> size of dictionary (adjective: $d.adjective.len) (adverb: $d.adverb.len) (noun: $d.noun.len) (verb: $d.verb.len)')
}

// random will return a single random string from an array of strings
fn random(strings &[]string) string {
	max := strings.len
	if max == 0 {
		println('verbose can not return a value from an empty word pool')
		return '?'
	}
	index := rand.intn(max)
	return strings[index]
}

// adjective returns a single random adjective
pub fn adjective() string {
	return random(dictionary.adjective)
}

// adjective returns a single random adverb
pub fn adverb() string {
	return random(dictionary.adverb)
}

// adjective returns a single random noun
pub fn noun() string {
	return random(dictionary.noun)
}

// adjective returns a single random verb
pub fn verb() string {
	return random(dictionary.verb)
}

// generate returns random chain of words based on an input pattern
// The pattern must be any number of 'adjective', 'adverb', 'noun' or 'verb'
// seperated by hyphens '-'
pub fn generate(pattern string) string {
	poses := pattern.split('-')
	mut returner := []string{len: poses.len}
	for i, pos in poses {
		mut pool := ['?']
		match pos {
			'noun' { pool = dictionary.noun }
			'verb' { pool = dictionary.verb }
			'adjective' { pool = dictionary.adjective }
			'adverb' { pool = dictionary.adverb }
			else {}
		}
		returner[i] = random(pool)
	}
	return returner.join('-')
}
