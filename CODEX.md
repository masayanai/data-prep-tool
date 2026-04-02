⏺ # data-prep-tool — Claude Session Boot                                                                                   
                            
  > Claude-specific configuration. Shared agent rules are in `AGENTS.md`.                                                  
                                                                                                                           
  ## Required Reading Order                                                                                                
                                                                                                                           
  Before working in this repository, follow shared rules in `AGENTS.md`                                                    
  and read these in order:
                                                                                                                           
  1. `AGENTS.md` — universal all-agent behavioral contract                                                                 
  2. `ARCHITECTURE_PRINCIPLES.md` — system constitution (highest authority)
  3. `docs/architecture/AUTHORITY_ORDER.md` — authority hierarchy map                                                      
  4. `docs/ai/AI_RULES.md` — AI participation rules and permissions policy                                                 
  5. `docs/development/ENGINEERING_PRACTICES.md` — development practices                                                   
  6. `docs/ai/CONTEXT_SNAPSHOT_latest.md` — current phase and recent progress                                              
                                                                                                                           
  Refer to as needed:                                                                                                      
                                                                                                                           
  - `docs/ai/README.md` — navigation map for docs/ai/                                                                      
  - `docs/ai/AI_CONTEXT.md` — architecture explainer (does not override authority docs)
                                                                                                                           
  ## Multi-Agent Review                                                                                                    
                                                                                                                           
  For complex reasoning or high-risk changes,                                                                              
  consider applying the multi-agent review protocol:               
                                                                                                                           
  `docs/ai/MULTI_AGENT_REVIEW_PROTOCOL.md`                         

  ## Current Development Phase                                                                                             
  
  See `docs/ai/CONTEXT_SNAPSHOT_latest.md` for current phase and recent progress.                                          
                                                                   
  ## Toolchain                                                                                                             
                                                                   
  ~~~bash
  # Dependency management
  uv sync
                                                                                                                           
  # QA (must complete before committing)
  ./scripts/qa.sh                                                                                                          
  # Or individually:                                                                                                       
  uv run ruff check .
  uv run ruff format . --check                                                                                             
  uv run mypy src tests                                            
  uv run pytest                                                                                                            
  ~~~
                                                                                                                           
  ## Commit Conventions                                            

  ~~~
  feat: description
  fix: description
  refactor: description
  docs: description   ← documentation-only changes                                                                         
  chore: description  ← infrastructure / tooling changes
  ~~~                                                                                                                      
                                                                   
  ## Absolute Rules (see AI_RULES.md for full permissions policy)                                                          
                                                                   
  1. **AI is a proposer, not a decider** — outputs are candidates and suggestions;                                         
     authoritative decisions flow through deterministic policy only
  2. **Do not modify existing tests to make a failing test pass** — implement the                                          
     minimum code to make the test pass                                                                                    
  3. **No direct push to main** — PR creation is the limit of AI responsibility
  4. **No secrets in code or command strings** — use file injection                                                        
  5. **Architecture changes require an ADR** — see `ARCHITECTURE_PRINCIPLES.md`                                            
                                                                                                                           
  ## When Uncertain                                                                                                        
                                                                                                                           
  - Architecture boundary unclear → `docs/ai/AI_CONTEXT.md` and                                                            
    `docs/architecture/AUTHORITY_ORDER.md`                         
  - Whether a change requires an ADR → `ARCHITECTURE_PRINCIPLES.md`                                                        
  - Test depth unclear → `docs/development/ENGINEERING_PRACTICES.md`                                                       
    Class A/B/C determination                                                                                              
  - Still unresolved → **do not implement; ask first**                                                                     
                                                                                                                           
❯ Can you output generic CODEX.md based on PROMPT_md_output.md?                                                            
                                                                                                                           
  Read 1 file (ctrl+o to expand)                                                                                           
                                                                   
⏺ # CODEX.md — OpenAI Codex Boot Instructions                                                                              
                                                                                                                           
  > Codex-specific configuration. Shared agent rules are in `AGENTS.md`.                                                   
                                                                                                                           
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
   
  ## Multi-Agent Review                                                                                                    
                                                                   
  For complex reasoning or high-risk changes,
  consider applying the multi-agent review protocol:

  `docs/ai/MULTI_AGENT_REVIEW_PROTOCOL.md`                                                                                 
   
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
   
  ## Codex-Specific Notes                                                                                                  
                                                                   
  - Codex operates in a sandboxed environment. Always run `uv sync` before
    executing tests.
  - Keep each task request scoped to a single TDD phase (RED, GREEN, or REFACTOR).
  - Do NOT create PRs directly — output the diff and commit message for human                                              
    review.
  - When given a task, always state which TDD phase you are operating in before                                            
    producing code.                                                                                                        
  - For repository operation permissions and escalation rules, defer to
    `docs/ai/AI_RULES.md` §Operational Permissions Policy.     