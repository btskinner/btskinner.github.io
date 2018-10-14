---
layout: page
---

## Economic

<div class="home">
    <ul class="posts">
		{% for post in site.categories.data %}
			{% for p in post.tags %}
				{% if p == 'econ' %}
					<li>
					<span style="float: left; width:90px">[{{ post.lang }}]
					</span>
					<a href="{{ post.url | prepend: site.baseurl }}">{{ post.title }}</a></li>
				{% endif %}
			{% endfor %}
		{% endfor %}
    </ul>
</div>

## Spatial

<div class="home">
    <ul class="posts">
		{% for post in site.categories.data %}
			{% for p in post.tags %}
				{% if p == 'spatial' %}
					<li>
					<span style="float: left; width:90px">[{{ post.lang }}]
					</span>
					<a href="{{ post.url | prepend: site.baseurl }}">{{ post.title }}</a></li>
				{% endif %}
			{% endfor %}
		{% endfor %}
    </ul>
</div>
