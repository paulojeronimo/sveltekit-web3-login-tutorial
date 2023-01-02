<script lang="ts">
	import { getContext } from 'svelte';

	const developer = getContext('developer');
	const project: string = getContext('project');
	const github = `https://github.com/${developer}/${project}`;
	const tutorial = `https://paulojeronimo.com/${project}`;
	const running_project = project.replace(/-tutorial$/, '');
	const github_running_project = github.replace(/-tutorial$/, '');
</script>

<h1>About</h1>
<hr />
<div class="parent">
	<ul>
		<li>GitHub source code: <a href={github}>{developer}/{project}</a></li>
		<li>
			GitHub Pages running code: <a href={github_running_project}>{developer}/{running_project}</a>
		</li>
		<li>Tutorial: <a href={tutorial}>{tutorial.replace(/^https:\/\//, '')}</a></li>
	</ul>
</div>

<style>
	div.parent {
		text-align: center;
	}
	ul {
		display: inline-block;
		text-align: left;
	}
</style>
