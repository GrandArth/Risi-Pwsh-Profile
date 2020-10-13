ifunction spgit {
	git config --global http.proxy 'socks5://127.0.0.1:9123';
	git config --global https.proxy 'socks5://127.0.0.1:9123';
	git config --global --get http.proxy;
}
function upgit {
	git config --global --unset http.proxy;
	git config --global --unset https.proxy;
	git config --global --get http.proxy;
}
