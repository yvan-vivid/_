#!/usr/bin/env bash
# =============================================================================
# test-omp.sh - Test Oh-My-Posh configurations in various scenarios
# =============================================================================

set -e

# Theme selection - can be overridden by -m flag or THEME env var
THEME="${THEME:-graphical}"

SHELL="${SHELL:-zsh}"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

print_header() {
	echo ""
	echo -e "${BLUE}========================================${NC}"
	echo -e "${BLUE}$1${NC}"
	echo -e "${BLUE}========================================${NC}"
}

print_test() {
	echo -e "${YELLOW}[TEST]${NC} $1"
}

print_pass() {
	echo -e "${GREEN}[PASS]${NC} $1"
}

print_fail() {
	echo -e "${RED}[FAIL]${NC} $1"
}

# Resolve config path based on theme
resolve_config() {
	# Skip if OMP_CONFIG was explicitly provided
	if [ -n "$OMP_CONFIG" ]; then
		return 0
	fi

	local config_dir="${XDG_CONFIG_HOME:-$HOME/.config}/oh-my-posh"

	case "$THEME" in
	graphical)
		OMP_CONFIG="$config_dir/graphical-theme.yaml"
		;;
	minimal)
		OMP_CONFIG="$config_dir/minimal-theme.yaml"
		;;
	*)
		echo "Unknown theme: $THEME"
		echo "Valid themes: graphical, minimal"
		exit 1
		;;
	esac

	# Fallback if file doesn't exist
	if [ ! -f "$OMP_CONFIG" ]; then
		OMP_CONFIG="$HOME/.config/oh-my-posh/${THEME}-theme.yaml"
	fi
}

# Check if oh-my-posh is available
check_omp() {
	print_header "Checking Oh-My-Posh Installation"

	print_test "Using theme: $THEME"
	echo ""

	if command -v oh-my-posh &>/dev/null; then
		print_pass "oh-my-posh is installed: $(oh-my-posh version)"
	else
		print_fail "oh-my-posh is not installed"
		exit 1
	fi

	if [ -f "$OMP_CONFIG" ]; then
		print_pass "Config file exists: $OMP_CONFIG"
	else
		print_fail "Config file not found: $OMP_CONFIG"
		exit 1
	fi
}

# Test path segment in various directories
test_path_segment() {
	print_header "Testing Path Segment"

	local test_dirs=(
		"~|home"
		"/|root"
		"/usr/local/bin|path from root"
		"/var/lib/containers/storage|path from root"
		"/src/repos/me|my repos"
		"/src/repos/forks|forks repos"
		"/data/media|media repo"
		"/data/media/Bio|media bio"
		"/tmp|tmp dir"
		"/etc|etc"
	)

	for test_case in "${test_dirs[@]}"; do
		local dir="${test_case%%|*}"
		local desc="${test_case#*|}"

		print_test "Path: $dir ($desc)"
		oh-my-posh print primary \
			--config="$OMP_CONFIG" \
			--shell="$SHELL" \
			--pwd="$dir" \
			2>/dev/null || echo "Error testing $dir"
		echo ""
	done
}

# Test git segment in various states
test_git_segment() {
	print_header "Testing Git Segment"

	# Create a temp directory for git tests
	local temp_dir
	temp_dir=$(mktemp -d)
	# Properly quote the trap to handle paths with spaces
	trap 'rm -rf "$temp_dir"' EXIT

	# Test clean repo
	print_test "Git: clean repo"
	cd "$temp_dir"
	git init -q
	oh-my-posh print primary --config="$OMP_CONFIG" --shell="$SHELL" 2>/dev/null || true
	echo ""

	# Test with untracked files
	print_test "Git: untracked files"
	echo "test" >"$temp_dir/untracked.txt"
	oh-my-posh print primary --config="$OMP_CONFIG" --shell="$SHELL" 2>/dev/null || true
	echo ""

	# Test with staged changes
	print_test "Git: staged changes"
	git -C "$temp_dir" add .
	oh-my-posh print primary --config="$OMP_CONFIG" --shell="$SHELL" 2>/dev/null || true
	echo ""

	# Test with modified files
	print_test "Git: modified files"
	echo "modified" >>"$temp_dir/untracked.txt"
	oh-my-posh print primary --config="$OMP_CONFIG" --shell="$SHELL" 2>/dev/null || true
	echo ""

	# Test with commits (ahead/behind)
	print_test "Git: with remote (if available)"
	# This would need a real remote to test ahead/behind
}

# Test different shells
test_shells() {
	print_header "Testing Different Shells"

	local shells=("zsh" "bash" "fish")

	for shell in "${shells[@]}"; do
		if command -v "$shell" &>/dev/null; then
			print_test "Shell: $shell"
			oh-my-posh print primary \
				--config="$OMP_CONFIG" \
				--shell="$shell" \
				--pwd="$HOME" \
				--plain \
				2>/dev/null || echo "Error with $shell"
			echo ""
		else
			print_test "Shell: $shell (not installed)"
		fi
	done
}

# Test debug mode
test_debug() {
	print_header "Testing Debug Mode"

	print_test "Debug output for home directory"
	oh-my-posh debug \
		--config="$OMP_CONFIG" \
		--shell="$SHELL" \
		--pwd="$HOME" 2>&1 | head -30

	echo ""
	print_test "Debug output for /src/repos/me/project"
	oh-my-posh debug \
		--config="$OMP_CONFIG" \
		--shell="$SHELL" \
		--pwd="/src/repos/me/project" 2>&1 | head -30
}

# Performance test
test_performance() {
	print_header "Testing Performance"

	print_test "Measuring prompt render time (10 iterations)"

	local total_time=0
	for i in {1..10}; do
		local start
		start=$(date +%s%N)
		oh-my-posh print primary \
			--config="$OMP_CONFIG" \
			--shell="$SHELL" \
			--pwd="$HOME" >/dev/null 2>&1
		local end
		end=$(date +%s%N)
		local elapsed=$(((end - start) / 1000000))
		total_time=$((total_time + elapsed))
	done

	local avg=$((total_time / 10))
	echo "Average render time: ${avg}ms"

	if [ "$avg" -lt 100 ]; then
		print_pass "Performance is good (<100ms)"
	elif [ "$avg" -lt 200 ]; then
		print_test "Performance is acceptable (100-200ms)"
	else
		print_fail "Performance needs improvement (>200ms)"
	fi
}

# Show usage
usage() {
	echo "Usage: $0 [OPTIONS]"
	echo ""
	echo "Options:"
	echo "  -a, --all         Run all tests (default)"
	echo "  -p, --path        Test path segment only"
	echo "  -g, --git         Test git segment only"
	echo "  -s, --shells      Test different shells"
	echo "  -d, --debug       Test debug mode"
	echo "  -t, --perf        Test performance"
	echo "  -m, --minimal     Use minimal theme (for TTY)"
	echo "  -h, --help        Show this help"
	echo ""
	echo "Environment variables:"
	echo "  OMP_CONFIG        Path to oh-my-posh config (default: ~/.config/oh-my-posh/{theme}-theme.yaml)"
	echo "  THEME            Theme to use: graphical or minimal (default: graphical)"
	echo "  SHELL             Shell to test (default: zsh)"
}

# Main
main() {
	local run_all=true
	local test_path=false
	local test_git=false
	local test_shells=false
	local test_debug=false
	local test_perf=false

	# Parse arguments
	while [ $# -gt 0 ]; do
		case "$1" in
		-a | --all)
			run_all=true
			;;
		-p | --path)
			run_all=false
			test_path=true
			;;
		-g | --git)
			run_all=false
			test_git=true
			;;
		-s | --shells)
			run_all=false
			test_shells=true
			;;
		-d | --debug)
			run_all=false
			test_debug=true
			;;
		-t | --perf)
			run_all=false
			test_perf=true
			;;
		-m | --minimal)
			THEME=minimal
			;;
		-h | --help)
			usage
			exit 0
			;;
		*)
			echo "Unknown option: $1"
			usage
			exit 1
			;;
		esac
		shift
	done

	# Resolve config path based on theme (after args parsed)
	resolve_config

	check_omp

	if $run_all; then
		test_path_segment
		test_git_segment
		test_shells
		test_performance
		test_debug
	else
		$test_path && test_path_segment
		$test_git && test_git_segment
		$test_shells && test_shells
		$test_debug && test_debug
		$test_perf && test_performance
	fi

	print_header "Tests Complete"
}

main "$@"
