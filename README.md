# Check for Conflicts Action

This action check for conflicts in your PR and prints "Hello World" or "Hello" + the name of a person to greet to the log.

Sometimes we make PRs and if they are left for some time, conflicts may arise. <br>
This action simply finds if we have any instances of files with merge conflicts we didn't resolve and reports them.

## Inputs

* `who-to-greet` <br>
**Required** <br>
The name of the person to greet. <br>
*Default*: `"World"`.

## Outputs

* `time` <br>
The time we greeted you and conflicts if any.

## Example-Usage

This is a Github action, so it has to be added to a github workflow.  
A simple example of running this action on all pushes to the repository would be
add a `main.yml` file under `.github/workflows` with the following content

```yml
on: [push]

jobs:
  merge_conflict_job:
    runs-on: ubuntu-latest
    name: Find merge conflicts
    steps:
      # Checkout the source code so we have some files to look at.
      - uses: actions/checkout@v2
      # Run the actual merge conflict finder
      - name: Check for Conflicts Action
        uses: actions/check-for-conflicts@v2.0
        with:
          who-to-greet: 'Noviicee'
```

On each push, it will now run the merge conflict finder

### Excludes
You can also add custom excludes to the search through the following inputs:

#### `exclude_dir`
A comma separate list of directories to ignore. The .git folder is always ignored

#### `excludes`
A comma separated list of files to ignore. Supports wildcard matching. 

A workflow with the inputs could look like:

```yaml
on: [push]

jobs:
  merge_conflict_job:
    runs-on: ubuntu-latest
    name: Find merge conflicts
    steps:
      # Checkout the source code so we have some files to look at.
      - uses: actions/checkout@v2
      # Run the actual merge conflict finder
      - name: Check for Conflicts Action
        uses: actions/check-for-conflicts@v2.0
        with:
          who-to-greet: 'Noviicee'
          exclude_dir: "path/to/ignore,path/to/ignore2"
          excludes: "ignore.me,*.zip"
```

<hr>

> Make sure to make the `checkconflicts.sh` file executable by running the following command on your system.
