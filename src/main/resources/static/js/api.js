(function () {
    var base = "https://evalora.up.railway.app";
    if (window.API_BASE && typeof window.API_BASE === "string") {
        base = window.API_BASE;
    }
    base = base.replace(/\/$/, "");

    window.API_BASE = base;
    window.apiFetch = function (path, options) {
        return fetch(base + path, options);
    };
})();
