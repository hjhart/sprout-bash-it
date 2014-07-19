# sprout-exemplar cookbook

[![Build Status](https://travis-ci.org/hjhart/sprout-bash-it.png?branch=master)](https://travis-ci.org/hjhart/sprout-bash-it)

Template repo for creating standalone cookbooks

## Usage

### Prerequisites

- [system ruby](.ruby-version)
- [bundler](http://bundler.io/)

### Quickstart

```
bundle
bundle exec soloist
```

## Cookbook Usage

### Attributes

*NOTE:* All preferences are namespaced under `sprout => bash_it` they include:

* `theme` &mdash; Bash it theme to use, defaults to 'bobby'
* `repository` &mdash; Repository to use. If you want to use a different theme, fork the original.
* `bashrc_path`  &mdash; Defaults to ~/.bash_profile
* `dir`  &mdash; Directory to store bash_it. Defaults to ~/.bash_it
* `custom_plugins` &mdash; Hash of 'cookbook' => 'Custom plugins to install.' Check `attributes/default` for defaults.
* `enabled_plugins` &mdash; Plugins to enable in bash-it. Check `attributes/default` for defaults.

### Recipes

1. `sprout-bash-it`
1. `sprout-bash-it::custom_plugins`
1. `sprout-bash-it::enabled_plugins`

## Contributing

### Before committing

```
bundle
bundle exec rake
```

The default rake task includes rubocop, foodcritic, unit specs

### [Rubocop](https://github.com/bbatsov/rubocop)

```
bundle
bundle exec rake rubocop
```

### [FoodCritic](http://acrmp.github.io/foodcritic/)

```
bundle
bundle exec rake foodcritic
```

### Unit specs

Unit specs use [ServerSpec](http://serverspec.org/)

```
bundle
bundle exec rake spec:unit
```

### Integration specs

Integrations specs will run the default recipe on the host system (destructive) and make assertions on the system after
install.

*Note:* It has a precondition that exemplar is _not_ already installed on the system.

```
bundle
bundle exec rake spec:integration
```
