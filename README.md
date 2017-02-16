# Pencil

Kata definition : https://github.com/mcsearchin/PencilKata-Groovy

## Running Tests
If you have elixir installed, then simply run ```mix test ``` in the checked out project.


If you have docker installed, then run the following command in the checked out project.

```
  docker run -it --rm -h elixir.local -v "$PWD":/usr/src/myapp -w /usr/src/myapp elixir bash -c "mix local.hex --force; mix test"
```
