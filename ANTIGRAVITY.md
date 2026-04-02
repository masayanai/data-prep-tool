⏺ # ANTIGRAVITY.md — Antigravity Boot Instructions                                                                         
                                                                                                                           
  > Antigravity-specific configuration. Shared agent rules are in `AGENTS.md`.                                             
                                                                                                                           
  ## Boot Sequence                                                                                                         
                                                                                                                           
  Before any work, follow `AGENTS.md` for shared rules and read these files in order:                                      
   
  1. `AGENTS.md` — all-agent behavioral contract (READ FIRST)                                                              
  2. `ARCHITECTURE_PRINCIPLES.md` — system constitution            
  3. `docs/architecture/AUTHORITY_ORDER.md` — canonical authority hierarchy
  4. `docs/ai/AI_RULES.md` — AI participation rules and permissions policy                                                 
  5. `docs/development/ENGINEERING_PRACTICES.md` — development practices
  6. Applicable skills under `docs/ai/skills/` (see `SKILL_WORKFLOW.md`)                                                   
                                                                                                                           
  Consult when relevant:
                                                                                                                           
  - `docs/ai/README.md` — AI documentation map, stable entrypoints, and archive
    boundaries; does not override authority documents
  - `docs/ai/AI_CONTEXT.md` — architecture and AI participation explainer;
    does not override authority documents                                                                                  
  - `docs/ai/CONTEXT_SNAPSHOT_latest.md` — current phase context and recent
    progress; does not override authority documents                                                                        
                                                                   
  ## Skills

  Before each TDD phase transition, consult the appropriate skill:

  - `docs/ai/skills/slice-design-review/SKILL.md` — before RED                                                             
  - `docs/ai/skills/green-implementation-guard/SKILL.md` — during/after GREEN
  - `docs/ai/skills/refactor-audit/SKILL.md` — during/after REFACTOR                                                       
  - `docs/ai/skills/pr-summary-and-commit/SKILL.md` — before commit/PR                                                     
  - `docs/ai/skills/context-snapshot-update/SKILL.md` — at session end
                                                                                                                           
  See `docs/ai/skills/SKILL_WORKFLOW.md` for the full chain.       
                                                                                                                           
  ## Toolchain                                                     

  ~~~bash
  uv sync                          # dependency management
  ./scripts/qa.sh                  # full QA (run before commit)
  uv run ruff check .              # lint
  uv run ruff format . --check     # format check                                                                          
  uv run mypy src tests            # type check
  uv run pytest                    # tests                                                                                 
  ~~~                                                              

  ## Commit Conventions

  ~~~
  feat: description
  fix: description
  refactor: description
  docs: description    ← documentation-only changes                                                                        
  chore: description   ← infrastructure / tooling changes
  ~~~                                                                                                                      
                                                                   
  ## Antigravity-Specific Notes

  - When operating autonomously, always confirm the current TDD phase before                                               
    generating code.
  - Respect the authority boundary: AI outputs are proposals, not decisions.                                               
  - If a task spans multiple TDD phases, break it into separate operations and
    confirm each phase transition.
  - Run `./scripts/qa.sh` after each phase to verify no regressions.
  - For repository operation permissions and escalation rules, defer to                                                    
    `docs/ai/AI_RULES.md` §Operational Permissions Policy.
