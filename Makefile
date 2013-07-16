coffee:
	./node_modules/.bin/coffee --watch --compile --output ./ coffee

watch-test:
	./node_modules/.bin/mocha \
		--watch \
		--reporter nyan

test:
	./node_modules/.bin/mocha \
		--reporter list

.PHONY: test coffee
