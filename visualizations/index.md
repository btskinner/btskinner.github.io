---
layout: page
---

## Maps

<div class="home">
	<ul class="posts">
		{% for post in site.categories.maps %}
			<li><span>{{ post.date | date: site.date_format }}</span>
			<a href="{{ post.subdir | prepend: site.baseurl }}">
				{{ post.title }}</a></li>	
			<p><a href="{{ post.subdir | prepend: site.baseurl }}">
				{{ post.excerpt }}</a></p>
		{% endfor %}
    </ul>
</div>

