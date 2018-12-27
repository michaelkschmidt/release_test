# Cachex Release Test

This demonstrates an issue running `Cachex` when stripping the release

From the shell, run:

```
mix deps.get
MIX_ENV=prod mix release
_build/prod/rel/release_test/bin/release_test console
```

Then attempt to use `Cachex`

```
iex(release_test@127.0.0.1)1> Cachex.start_link :some_cache, limit: 7
{:error, :invalid_hook}
```
