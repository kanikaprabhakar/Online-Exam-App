(function () {
    const AUTH_TOKEN_KEY = 'authToken';
    const USER_DATA_KEY = 'userData';

    window.Auth = {
        saveToken: function (token) {
            localStorage.setItem(AUTH_TOKEN_KEY, token);
        },

        getToken: function () {
            return localStorage.getItem(AUTH_TOKEN_KEY);
        },

        saveUserData: function (data) {
            localStorage.setItem(USER_DATA_KEY, JSON.stringify(data));
        },

        getUserData: function () {
            const data = localStorage.getItem(USER_DATA_KEY);
            return data ? JSON.parse(data) : null;
        },

        isAuthenticated: function () {
            return !!this.getToken();
        },

        getRole: function () {
            const userData = this.getUserData();
            return userData ? userData.role : null;
        },

        isAdmin: function () {
            return this.getRole() === 'ADMIN';
        },

        isStudent: function () {
            return this.getRole() === 'STUDENT';
        },

        logout: function () {
            localStorage.removeItem(AUTH_TOKEN_KEY);
            localStorage.removeItem(USER_DATA_KEY);
            window.location.href = 'login.html';
        },

        requireAuth: function (requiredRole) {
            if (!this.isAuthenticated()) {
                window.location.href = 'login.html?error=auth_required';
                return false;
            }
            
            if (requiredRole) {
                const role = this.getRole();
                if (role !== requiredRole) {
                    window.location.href = 'login.html?error=access_denied';
                    return false;
                }
            }
            
            return true;
        },

        // Add Authorization header to fetch options
        addAuthHeader: function (options) {
            options = options || {};
            options.headers = options.headers || {};
            
            const token = this.getToken();
            if (token) {
                options.headers['Authorization'] = 'Bearer ' + token;
            }
            
            return options;
        }
    };

    // Override apiFetch to automatically include auth header
    if (window.apiFetch) {
        const originalApiFetch = window.apiFetch;
        window.apiFetch = function (path, options) {
            return originalApiFetch(path, Auth.addAuthHeader(options));
        };
    }
})();
