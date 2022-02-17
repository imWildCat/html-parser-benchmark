test:
	rm -r swift/Tests/HTMLParserBenchmarkSwiftTests/Resources/*.html || rm -r swift/Tests/HTMLParserBenchmarkSwiftTests/Resources/*.txt || exit 0
	find ../fixtures/wikipedia -name "*.*" -type f -exec cp '{}' Tests/HTMLParserBenchmarkSwiftTests/Resources/ \;