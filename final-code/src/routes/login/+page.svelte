<script lang="ts">
	import { Form, Input, Button, FormGroup, Alert } from 'sveltestrap';
	import { initializeApp } from 'firebase/app';
	import {
		getAuth,
		createUserWithEmailAndPassword,
		type User,
		signInWithEmailAndPassword,
		signOut,
		onAuthStateChanged
	} from 'firebase/auth';
	import { onMount } from 'svelte';

	const firebaseConfig = {
		apiKey: 'AIzaSyBFYadWRvXVKpErBlNmNVQVBjj8MM6Rr2A',
		authDomain: 'sveltekit-web3-login-f0618.firebaseapp.com',
		projectId: 'sveltekit-web3-login-f0618',
		storageBucket: 'sveltekit-web3-login-f0618.appspot.com',
		messagingSenderId: '157302726728',
		appId: '1:157302726728:web:89ad8af2f4dc6c4b58b87d'
	};
	const app = initializeApp(firebaseConfig);

	let email = '';
	let password = '';
	let user: User | null;
	let opError: any | null = null;

	// A quick and dirty validation
	// It will be refactored to use Zod on the next commits
	const isLengthValid = (field: string | undefined, fieldLength: number) => { 
		return field !== undefined ? field.length >= emailLength : undefined;
	}
	const isEmailValid = (email: string, emailLength: number) => {
		const emailRegex =
			/^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
		return isLengthValid(email, emailLength) !== undefined ? emailRegex.test(email) : undefined;
	};

	const emailLength = 6;
	const passwordLength = 6;

	function validateSubmit() {
		opError = null;
		if (!isEmailValid(email, emailLength)) {
			opError = {};
			opError.message = 'email is invalid';
			throw opError;
		}
		if (!isLengthValid(password, passwordLength)) {
			opError = {};
			opError.message = 'password is invalid';
			throw opError;
		}
	}

	const login = async () => {
		const auth = getAuth(app);
		try {
			validateSubmit();
			const userCredential = await signInWithEmailAndPassword(auth, email, password);
			user = userCredential.user;
		} catch (error) {
			opError = error;
		}
	};

	const register = async () => {
		const auth = getAuth(app);
		try {
			validateSubmit();
			const userCredential = await createUserWithEmailAndPassword(auth, email, password);
			user = userCredential.user;
		} catch (error) {
			opError = error;
		}
	};

	const logout = async () => {
		const auth = getAuth(app);
		try {
			await signOut(auth);
			user = null;
			opError = null;
			email = '';
			password = '';
		} catch (error) {
			opError = error;
		}
	};

	onMount(() => {
		const auth = getAuth(app);
		onAuthStateChanged(auth, (authUser) => (user = authUser));
	});
</script>

<h1>Login | Register</h1>
<hr />

<Form>
	{#if user}
		<FormGroup>
			<p>User {user.email} is logged in</p>
			<Button type="submit" on:click={logout}>Logout</Button>
		</FormGroup>
	{:else}
		<FormGroup>
			<Input
				id="exampleInputEmail1"
				type="email"
				placeholder="Enter a valid email"
				minlength={emailLength}
				valid={isEmailValid(email, emailLength)}
				bind:value={email}
			/>
		</FormGroup>
		<FormGroup>
			<Input
				id="exampleInputPassword1"
				type="password"
				placeholder="Enter a STRONG password"
				minlength={passwordLength}
				valid={isLengthValid(password, passwordLength)}
				bind:value={password}
			/>
		</FormGroup>
		{#if opError}
			<Alert color="danger">
				<p>{opError.message}</p>
			</Alert>
		{/if}
		<FormGroup>
			<Button type="submit" on:click={login}>Login</Button>
			<Button type="submit" on:click={register}>Register</Button>
		</FormGroup>
	{/if}
</Form>
