# Test Desiderata Documentation Commands

# Set up Ruby environment
export PATH := env_var('HOME') + "/.rbenv/shims:/opt/homebrew/bin:" + env_var('PATH')

# List available commands
default:
    @just --list

# Install Ruby dependencies
install:
    bundle install

# Update Ruby dependencies
update:
    bundle update

# Start local Jekyll server
serve:
    bundle exec jekyll serve --source docs --port 4000

# Start local Jekyll server with live reload
serve-livereload:
    bundle exec jekyll serve --source docs --port 4000 --livereload

# Build the site
build:
    bundle exec jekyll build --source docs

# Clean build artifacts
clean:
    rm -rf _site .sass-cache .jekyll-cache .jekyll-metadata

# Validate all markdown links work
check-links:
    @echo "Checking that all .md files exist..."
    @cd docs && for file in *.md; do \
        grep -oh '\[.*\]([a-z-]*\.md)' "$$file" | \
        sed 's/.*(\(.*\)\.md)/\1.md/' | \
        while read link; do \
            if [ ! -f "$$link" ]; then \
                echo "Missing: $$link (referenced in $$file)"; \
            fi; \
        done; \
    done
    @echo "Done checking links."

# Check GitHub Pages dependency versions
check-versions:
    @echo "GitHub Pages Dependency Versions:"
    @echo "=================================="
    @curl -s https://pages.github.com/versions.json | jq -r '.ruby, .jekyll, .["jekyll-theme-architect"], .["jekyll-relative-links"], .["kramdown-parser-gfm"]' | \
        awk 'BEGIN {deps[0]="ruby"; deps[1]="jekyll"; deps[2]="jekyll-theme-architect"; deps[3]="jekyll-relative-links"; deps[4]="kramdown-parser-gfm"} {printf "%-25s %s\n", deps[NR-1]":", $0}'

# Show git status
status:
    git status --short

# Create commit (requires message)
commit MESSAGE:
    git add docs/*.md docs/_config.yml
    git commit -m "{{MESSAGE}}"
