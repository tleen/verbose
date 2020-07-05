import verbose

fn test_adjective() {
	s := verbose.adjective()
	assert typeof(s) == 'string'
	assert s.len > 0
}

fn test_adverb() {
	s := verbose.adverb()
	assert typeof(s) == 'string'
	assert s.len > 0
}

fn test_noun() {
	s := verbose.noun()
	assert typeof(s) == 'string'
	assert s.len > 0
}

fn test_verb() {
	s := verbose.verb()
	assert typeof(s) == 'string'
	assert s.len > 0
}

fn test_generate() {
	phrase := verbose.generate('adverb-adjectives-verb-noun')
	assert phrase.split('-').len == 4
}

fn test_generate_empty() {
	phrase := verbose.generate('')
	assert typeof(phrase) == 'string'
	assert phrase.len == 0
}

fn test_generate_lengths() {
	lengths := [1, 2, 4, 8, 16, 32, 64, 128, 256, 512, 1024]
	for length in lengths {
		phrase_array := []string{len: length, init: 'noun'}
		phrase := verbose.generate(phrase_array.join('-'))
		assert typeof(phrase) == 'string'
		assert phrase.split('-').len == length
	}
}
