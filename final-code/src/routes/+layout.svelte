<script lang="ts">
	import { base } from '$app/paths';
	import { Styles } from 'sveltestrap';
	import { Container } from 'sveltestrap';
	import { Col, Row } from 'sveltestrap';
	import NavBar from '../components/NavBar.svelte';
	import { setContext } from 'svelte';

	setContext('base', base);
	setContext('developer', 'paulojeronimo');
	setContext('project', 'sveltekit-web3-login-tutorial');
</script>

<Styles />

<NavBar />

<Container>
	<Row>
		<Col class="text-center">
			<slot />
		</Col>
	</Row>
</Container>
