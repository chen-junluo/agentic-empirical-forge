# Word Output Formatting Conventions

> Applies to AEF agents that create or revise `.docx` files. This file covers reusable Word conventions. Stage-specific layout requirements remain in their own references, such as `AEF07_rebuttal/references/response-letter-docx-format.md`.

- **Inline math** [User] Avoid Word inline equation objects when practical. Format subscripts and superscripts with Word's subscript and superscript styling rather than literal `_` or `^` notation. Check spacing immediately after each inline expression so the following word is not joined to it or separated by an unintended gap.
- **Hyphen character** [User] In Word prose, use the hyphen-minus `-` instead of the en dash `–` to reduce formulaic AI-style punctuation.
- **Regression coefficient precision** [User] Follow `shared/table-conventions.md` **Coefficient precision** for regression tables.

## Output Check

- Check inline variables and expressions for actual subscript/superscript styling, literal `_` or `^` notation, and spacing after each expression.
- Search the Word text for en dashes and replace them with hyphens.
- Check regression tables against `shared/table-conventions.md` **Coefficient precision**.
