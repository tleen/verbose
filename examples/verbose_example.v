import verbose

fn main() {
	verbose.init()
	println('phrase: ' + verbose.generate('adverb-adjective-verb-noun'))
	// phrase: tepidly-rattier-permeates-albany
	println('adjective: ' + verbose.adjective())
	// adjective: neuritic
	println('adverb: ' + verbose.adverb())
	// adverb: decurrently
	println('noun: ' + verbose.noun())
	// noun: ceasefire
	println('verb: ' + verbose.verb())
	// verb: coincide
}
