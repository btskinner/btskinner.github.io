---
layout: page
---

## Software packages

<div class="home">
    <ul class="posts">
		{% for post in site.categories.code %}
			{% for p in post.tags %}
				{% if p == 'packages' %}
					<li>
					<span style="float: left; width:90px">[{{ post.lang }}]
					</span>
					<a href="{{ post.url | prepend: site.baseurl }}">{{ post.title }}</a>
					</li>
				{% endif %}
			{% endfor %}
		{% endfor %}
    </ul>
</div>


## Data analysis

<div class="home">
    <ul class="posts">
		{% for post in site.categories.code %}
			{% for p in post.tags %}
				{% if p == 'data' %}
					<li>
					<span style="float: left; width:90px">[{{ post.lang }}]
					</span>
					<a href="{{ post.url | prepend: site.baseurl }}">{{ post.title }}</a>
					</li>
				{% endif %}
			{% endfor %}
		{% endfor %}
    </ul>
</div>

## Document preparation

<div class="home">
    <ul class="posts">
		{% for post in site.categories.code %}
			{% for p in post.tags %}
				{% if p == 'doc' %}
					<li>
					<span style="float: left; width:90px">[{{ post.lang }}]
					</span>
					<a href="{{ post.url | prepend: site.baseurl }}">{{ post.title }}</a>
					</li>
				{% endif %}
			{% endfor %}
		{% endfor %}
    </ul>
</div>

## Miscellaneous

<div class="home">
    <ul class="posts">
		{% for post in site.categories.code %}
			{% for p in post.tags %}
				{% if p == 'misc' %}
					<li>
					<span style="float: left; width:90px">[{{ post.lang }}]
					</span>
					<a href="{{ post.url | prepend: site.baseurl }}">{{ post.title }}</a>
					</li>
				{% endif %}
			{% endfor %}
		{% endfor %}
    </ul>
</div>



