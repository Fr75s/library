// This just initializes the header for each page.

document.getElementById("header").innerHTML = `
<div class="row edgerow header">
	<p style="margin: 10px; margin-left: 30px; font-family: Outfit; font-weight: 600;">Library</p>
	<div class="row">
		<a href="main.html" class="rowitem hlink">Home</a>
		<a href="gallery.html" class="rowitem hlink">Gallery</a>
		<a href="install.html" class="rowitem hlink">Installation</a>
	</div>
</div>
`;


document.getElementById("footer").innerHTML = `
<div class="row edgerow">
	<p style="margin: 30px; font-family: Outfit; font-weight: 600;">Theme & Website by <a href="https://github.com/Fr75s/">Fr75s.</a></p>

	<a href="https://github.com/Fr75s/library" class="rowitem" style="margin: 30px;">Source Code</a>
</div>
`;

