# Build results overview for requests

## Implementation details

* Revise what icons are used for states
  * Make sure  that every state icon is unique
  * Make sure that icons don't look like other UI elements (like close button)
* Improve default filtering
  * Allow displaying excluded and disabled arches, but don't display them with default filtering
* The icon summary in the accordion header
  * Needs to be done per category (failed blocked processing suceeded disabled)
  * Needs to reflect colors of the states in the category
    * This may require adjusting the current state colors (preferably semantically, failed and succeeded are obvious, but blocked is a warning state, while processing is just info since we don't know the outcome)
* The individual arch badges link to the build log/display more information when pressed (a'la the current unresolvable in the monitor)
* Link to the code changes from the header ([implementation clue](https://stackoverflow.com/questions/67281841/bootstrap-link-in-accordion-header-stoppropagation-not-working))
* The arches in the repositories should be aligned using css grid, such that on higher viewports they display as a table with architectures that don't exist in a certain repo are empty cells (for easy comparison between repository state), but on low viewports they all display as a vertical list so that it fits well without the need to scroll

## How to use this mockup

If you want to update the status.xml response, or generate json for the mockup, replace the existing status.xml (with the output of `osc api /build/openSUSE:Tools/_result?view=status&locallink=1&multibuild=1`) and then run:
```
cd _data
ruby transform_data.rb
```

If you want to serve the site locally run:
```
bundler install
bundler exec jekyll serve
```

Or simply run `docker-compose up` and check the mockup in `localhost:4000`.
