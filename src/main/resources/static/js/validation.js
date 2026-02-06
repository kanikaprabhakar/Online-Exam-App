(function () {
    function ensureErrorEl(input) {
        var next = input.nextElementSibling;
        if (!next || !next.classList.contains("field-error")) {
            next = document.createElement("div");
            next.className = "field-error";
            input.insertAdjacentElement("afterend", next);
        }
        return next;
    }

    function validateInput(input) {
        if (input.disabled || input.readOnly) {
            return true;
        }

        var value = input.value.trim();
        var rule = input.dataset.validate || "";
        var optional = input.dataset.optional === "true";
        var message = "";

        if (!value) {
            if (input.required && !optional) {
                message = "This field is required.";
            }
        } else if (rule === "email") {
            if (!/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(value)) {
                message = "Enter a valid email (must include @ and .).";
            }
        } else if (rule === "phone") {
            if (!/^\d{10}$/.test(value)) {
                message = "Phone must be exactly 10 digits.";
            }
        } else if (rule === "roll") {
            if (!/^\d{8}$/.test(value)) {
                message = "Roll number must be exactly 8 digits.";
            }
        } else if (rule === "password") {
            if (value.length < 8) {
                message = "Password must be at least 8 characters.";
            }
        }

        var errorEl = ensureErrorEl(input);
        if (message) {
            errorEl.textContent = message;
            errorEl.style.display = "block";
            input.classList.add("input-error");
            return false;
        }

        errorEl.textContent = "";
        errorEl.style.display = "none";
        input.classList.remove("input-error");
        return true;
    }

    function initForm(form) {
        var inputs = form.querySelectorAll("input[data-validate], textarea[data-validate]");
        if (!inputs.length) {
            return;
        }

        inputs.forEach(function (input) {
            ensureErrorEl(input);
            input.addEventListener("input", function () {
                validateInput(input);
            });
            input.addEventListener("blur", function () {
                validateInput(input);
            });
        });

        form.addEventListener("submit", function (event) {
            var isValid = true;
            inputs.forEach(function (input) {
                if (!validateInput(input)) {
                    isValid = false;
                }
            });

            if (!isValid) {
                event.preventDefault();
            }
        });
    }

    function init() {
        var forms = document.querySelectorAll("form[data-validate]");
        forms.forEach(function (form) {
            initForm(form);
        });
    }

    document.addEventListener("DOMContentLoaded", init);
    window.EvaloraValidation = { init: init };
})();
