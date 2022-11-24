install:
	swift build -c release
	install .build/release/satus-cli /usr/local/bin/satus
