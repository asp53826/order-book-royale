.PHONY: test serve

test:
	uv run python tests/js/make_golden.py
	git diff --exit-code tests/js/golden.json
	node --test tests/js/*.test.mjs

serve:
	python3 -m http.server 8000 --directory docs
