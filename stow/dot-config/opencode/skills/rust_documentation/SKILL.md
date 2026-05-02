---
name: rust_documentation
description: Guidelines for writing Rust documentation strings
---

## Docstring Style Preferences

- Reference code artifacts like functions and structs with `backticks`. Do not attempt to form links.

### Example

```rust
/// Creates a new `SchedulingService` instance.
///
/// # Arguments
///
/// * `config` - The configuration to use for the service.
/// * `db_pool` - A connection pool for database access.
///
/// # Returns
///
/// A new `SchedulingService` ready to accept tasks.
///
/// # Panics
///
/// Panics if `db_pool` is empty or `config.max_workers` exceeds system limits.
///
/// # Examples
///
/// ```
/// use ground_control_orchestrator::scheduling_service::SchedulingService;
///
/// let service = SchedulingService::new(config, db_pool);
/// assert!(service.is_ready());
/// ```
pub fn new(config: Config, db_pool: PgPool) -> Self { ... }
```
