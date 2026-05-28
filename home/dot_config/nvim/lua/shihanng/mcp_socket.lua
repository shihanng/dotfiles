-- Returns the nvim-mcp socket path for the current Neovim instance.
-- Format: <socket_dir>/nvim-mcp.<basename24>-<hash8>.<pid>.sock
--
-- The full escaped-path format used by nvim-mcp upstream exceeds macOS's
-- 104-character Unix socket path limit (sun_path) for deep project trees.
-- Instead we embed the last path component (truncated to 24 chars) plus the
-- first 8 hex chars of a SHA-256 hash of the full git root for uniqueness.
--
-- Trade-off: `nvim-mcp --connect auto` matches sockets by escaped project
-- root and won't discover these sockets automatically. Use `<leader>ll` to
-- get the exact path and pass it via `nvim-mcp --connect <path>`.
local function get_socket_dir()
    local dir
    local xdg = os.getenv("XDG_RUNTIME_DIR")
    if xdg and xdg ~= "" then dir = xdg end
    if not dir then
        local tmpdir = os.getenv("TMPDIR")
        if tmpdir and tmpdir ~= "" then dir = tmpdir end
    end
    if not dir then dir = "/tmp" end
    -- Strip trailing slash (macOS sets TMPDIR with a trailing slash)
    return dir:gsub("/$", "")
end

local git_root
local handle = io.popen("git rev-parse --show-toplevel 2>/dev/null")
if handle then
    local result = handle:read("*a")
    handle:close()
    if result and result ~= "" then
        git_root = result:gsub("^%s+", ""):gsub("%s+$", "")
    end
end
git_root = git_root or vim.fn.getcwd()

-- Basename of the git root, truncated to 24 chars for readability
local basename = git_root:match("[^/]+$") or git_root
if #basename > 24 then basename = basename:sub(1, 24) end

-- 8-char hex prefix of sha256(git_root) for uniqueness
local hash8 = vim.fn.sha256(git_root):sub(1, 8)

return string.format("%s/nvim-mcp.%s-%s.%d.sock", get_socket_dir(), basename, hash8, vim.fn.getpid())
