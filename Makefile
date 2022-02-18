all:
	cd golang && make test
	cd javascript && make test
	cd rust && make test
	cd swift && make test

collect-dependencies:
	cd golang && make collect-dependencies
	cd javascript && make collect-dependencies
	cd rust && make collect-dependencies
	cd swift && make collect-dependencies

gen-report:
	cd scripts && npm run build