# use Smyck color theme for bat
export BAT_THEME="Smyck"

if [[ "$OSTYPE" == "darwin"* ]]; then
	if [[ "$(uname -m)" == "arm64" ]]; then
		# ARM macOS specific configurations
		export PATH="/opt/homebrew/share/git-core/contrib/diff-highlight:$PATH"
	else
		# Non-ARM macOS or other systems configuration
		export PATH="/usr/local/share/git-core/contrib/diff-highlight:$PATH"
	fi
fi
