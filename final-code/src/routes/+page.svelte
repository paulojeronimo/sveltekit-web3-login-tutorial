<script lang="ts">
	import { getContext } from 'svelte';

	const base = getContext('base');
</script>

<h1>SvelteKit Web3 (and Web2) Login Demo</h1>
<hr />
<p>
	<a href="{base}/login">Login | Register</a>
	(using Web2)
</p>
<p><a href="{base}/login-web3">Login (Web3)</a> using your crypto wallet</p>
