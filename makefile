.PHONY: help
help: ## Show this help message.
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'


.PHONY: install_go
install_go:
	chmod +x scripts/install_go.sh
	./scripts/install_go.sh


.PHONY: install_python
install_python:
	chmod +x scripts/install_python.sh
	./scripts/install_python.sh


.PHONY: install_tools
install_tools:
	chmod +x scripts/install_tools.sh
	./scripts/install_tools.sh

.PHONY: install_fonts
install_fonts:
	chmod +x scripts/install_fonts.sh
	./scripts/install_fonts.sh
