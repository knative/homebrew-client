## Homebrew Tap for Knative client `kn`

This repository contains the [Hombrew Tap](https://docs.brew.sh/Taps) for Knative clients.

To enable this Tap globally, use

```
brew tap knative/client
```

The supported clients are:

* [kn](https://github.com/knative/client) - The Knative CLI client


Install them with `brew install` like in

```
brew install kn
```

Alternatively you can also install the clients directly (without adding a tap globally) with

```
brew install knative/client/kn
```

This repo is now using `main` as default branch. If you had tapped `knative/client` earlier,
and now unable to upgrade `kn`, it's because brew could not locate the respective refs in this
repo. To fix it, you'd need to tap the repo afresh (with `main` default branch)

```
brew uninstall kn
brew untap knative/client --force
brew tap knative/client
brew install kn
```

## Contributing

If you would like to contribute to Knative, take a look at [CLOTRIBUTOR](https://clotributor.dev/search?project=knative&page=1)
for a list of help wanted issues in the project.
