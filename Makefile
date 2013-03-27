coffee:
	coffee --watch --compile --output ./ coffee

watch-test:
	./node_modules/.bin/mocha \
	  --watch \
	  --reporter landing

test:
	./node_modules/.bin/mocha \
		--reporter list

.PHONY: test coffee