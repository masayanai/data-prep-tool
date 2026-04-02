⏺ # data-prep-tool — Claude Session Boot                                                                                   
                            
  > Claude-specific configuration. Shared agent rules are in `AGENTS.md`.                                                  
                                                                                                                           
  ## Required Reading Order                                                                                                
                                                                                                                           
  Before working in this repository, follow shared rules in `AGENTS.md`                                                    
  and read these in order:
                                                                                                                           
  1. `AGENTS.md` — universal all-agent behavioral contract
  2. `ARCHITECTURE_PRINCIPLES.md` — system constitution (highest authority)
  3. `docs/ai/AI_RULES.md` — AI participation rules and permissions policy
  4. `docs/data-handling-policy.md` — PII rules and output invariants
  5. `docs/development/ENGINEERING_PRACTICES.md` — development practices
  6. `docs/ai/CONTEXT_SNAPSHOT_latest.md` — current phase and recent progress

  Refer to as needed:

  - `docs/ai/README.md` — navigation map for docs/ai/
  - `docs/architecture/AUTHORITY_ORDER.md` — authority hierarchy reference
                                                                                                                           
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
  5. **PII rules are non-negotiable** — see `docs/data-handling-policy.md`
  6. **Architecture changes require human review** — see `ARCHITECTURE_PRINCIPLES.md §5`

  ## When Uncertain

  - Architecture boundary unclear → `ARCHITECTURE_PRINCIPLES.md` and `docs/architecture/AUTHORITY_ORDER.md`
  - PII classification unclear → `docs/data-handling-policy.md §1`
  - Test depth unclear → `docs/development/ENGINEERING_PRACTICES.md` Class A/B/C
  - Still unresolved → **do not implement; ask first**