# Create a new directory and enter it
mkd() {
	mkdir -p -- "$@" && cd -- "${@: -1}"
}

# Simple calculator: `calc 3/7`, `calc "s(1)"`
calc() {
	local result
	result=$(printf 'scale=10;%s\n' "$*" | bc --mathlib | tr -d '\\\n')
	if [[ $result == *.* ]]; then
		printf '%s' "$result" | sed -e 's/^\./0./' -e 's/^-\./-0./' -e 's/0*$//;s/\.$//'
	else
		printf '%s' "$result"
	fi
	printf '\n'
}

# Size of a file, or of every item in the current directory
fs() {
	if (( $# )); then
		du -sh -- "$@"
	else
		du -sh -- .[^.]*(N) *(N)
	fi
}

# Create a .tar.gz archive of a file or directory
targz() {
	local src=${1%/}
	[[ -e $src ]] || { echo "usage: targz <file|dir>" >&2; return 1; }
	tar -czvf "${src}.tar.gz" --exclude=".DS_Store" -- "$src" && echo "${src}.tar.gz created."
}

# Tree with hidden files, dirs first, no .git/node_modules, paged when long
tre() {
	tree -aC -I '.git|node_modules' --dirsfirst "$@" | less -FRNX
}

# Pretty-print JSON: `json '{"a":1}'` or `curl … | json`
json() {
	if [[ -t 0 ]]; then
		printf '%s' "$*" | jq .
	else
		jq .
	fi
}

# DNS lookup showing only the useful answer section
digga() {
	dig +nocmd "$1" +multiline +noall +answer
}

# Show the Common Name and SANs of a domain's TLS certificate
getcertnames() {
	[[ -n $1 ]] || { echo "usage: getcertnames <domain>" >&2; return 1; }
	local domain=$1
	echo "Testing ${domain}…"
	local cert
	cert=$(openssl s_client -connect "${domain}:443" -servername "${domain}" </dev/null 2>/dev/null \
		| openssl x509 -noout -subject -ext subjectAltName 2>/dev/null) \
		|| { echo "ERROR: Certificate not found." >&2; return 1; }
	print -r -- "$cert"
}

# Serve the current directory over HTTP — bound to localhost only, so it is
# not exposed to other machines on the network. `server [port]`
server() {
	local port=${1:-8000}
	(sleep 1 && open "http://localhost:${port}/") &!
	python3 -m http.server "$port" --bind 127.0.0.1
}
