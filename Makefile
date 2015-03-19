.PHONY: import

import:
	rm -rf src/foundation/generated/*.cr
	crystal bin/import.cr
