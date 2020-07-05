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
fn init() int {
	// Thanks to `!! ryan` on vlang discord for the initialization approach.
	sep := os.path_separator
	mut d := &Dictionary(dictionary)
	mut path_components := @FILE.split(sep)
	path_components[path_components.len - 1] = '.'
	path_components << ['data', 'en']
	path := path_components.join(sep) + sep
	// TODO: Is there an effective way to loop on this?
	adjectives := os.read_file(path + 'adjectives.txt') or {
		return 0
	}
	d.adjective << adjectives.trim_right('\n').split('\n')
	adverbs := os.read_file(path + 'adverbs.txt') or {
		return 0
	}
	d.adverb << adverbs.trim_right('\n').split('\n')
	nouns := os.read_file(path + 'nouns.txt') or {
		return 0
	}
	d.noun << nouns.trim_right('\n').split('\n')
	verbs := os.read_file(path + 'verbs.txt') or {
		return 0
	}
	d.verb << verbs.trim_right('\n').split('\n')
	return 1
}

// random will return a single random string from an array of strings
fn random(strings &[]string) string {
	max := strings.len
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
