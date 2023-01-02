<script lang="ts">
	import type { base } from 'src/types/Svelte';
	import { getContext } from 'svelte';
	import { Collapse, Navbar, NavbarToggler, NavbarBrand, Nav, NavItem, NavLink } from 'sveltestrap';

	// not strictly necessary to use the 'base' type here
	// but used to illustrate how to define this type
	const base: base = getContext('base');

	let isOpen = false;
	function handleUpdate(event) {
		isOpen = event.detail.isOpen;
	}
</script>

<Navbar color="light" light expand="md">
	<NavbarBrand href="{base}/">{getContext('project')}</NavbarBrand>
	<NavbarToggler on:click={() => (isOpen = !isOpen)} class="me-2" />
	<Collapse {isOpen} navbar expand="md" on:update={handleUpdate}>
		<Nav navbar class="ms-auto">
			<NavItem>
				<NavLink href="{base}/login">Login | Register</NavLink>
			</NavItem>
			<NavItem>
				<NavLink href="{base}/login-web3">Login (Web3)</NavLink>
			</NavItem>
			<!--
      <NavItem>
        <NavLink href="{base}/logout">Logout</NavLink>
      </NavItem>
      -->
			<NavItem>
				<NavLink href="{base}/about">About</NavLink>
			</NavItem>
		</Nav>
	</Collapse>
</Navbar>
