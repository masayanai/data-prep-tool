⏺ ---                                                                                                                      
  name: pr-summary-and-commit                                                                                              
  description: Generate structured PR summary and commit messages aligned with TDD phase boundaries. Use before committing 
  or creating a PR.                                                                                                        
  ---                                                                                                                      
                                                                                                                           
  # Trigger Conditions                                             

  - **Phase**: Any (RED / GREEN / REFACTOR / DOC / CHORE)                                                                  
  - **When**: Work is ready to be committed or a PR is being created
  - **Who**: All agents (Claude, Codex, Cursor, Antigravity)                                                               
  - **Signal**: Human requests "commit this" or "create a PR"; agent has completed
    implementation                                                                                                         
  
  # Procedure                                                                                                              
                                                                   
  ## 1. Change Summary
  - What was implemented or changed
  - Which slice (if applicable)

  ## 2. Scope Validation
  - Confirm no scope expansion beyond the intended change
                                                                                                                           
  ## 3. TDD Phase / Change Category
  - Slice work: RED / GREEN / REFACTOR / DOC                                                                               
  - Non-slice work: docs / chore                                   

  ## 4. Files Changed
  - High-level summary only

  ## 5. Risks / Follow-ups                                                                                                 
  
  # Output Format                                                                                                          
                                                                   
  ## Commit Message

  For slice-scoped changes:

  ~~~
  feat: concise summary       # new capability (RED → GREEN)
  fix: concise summary        # bug fix                                                                                    
  refactor: concise summary   # REFACTOR phase
  ~~~                                                                                                                      
                                                                   
  For non-slice changes:                                                                                                   
                                                                   
  ~~~
  docs: concise summary       # documentation outside slices
  chore: concise summary      # infra, tooling, CI changes
  ~~~

  ## PR Summary

  ### What
  ### Why
  ### Scope
  ### Risks                                                                                                                
  
  # Guardrails                                                                                                             
                                                                   
  - No vague language
  - No over-claiming
  - Keep factual and precise
  - Match commit prefix to actual change category

  # Violation Examples

  - ❌ Commit message says GREEN but includes new test files (that is RED)                                                 
  - ❌ PR summary claims "no scope expansion" while adding interfaces for a
    future slice                                                                                                           
  - ❌ Commit bundles RED + GREEN + REFACTOR changes in a single commit
  - ❌ PR description omits known risks or deferred gaps
  - ❌ Uses a slice prefix for a change to AGENTS.md (non-slice doc → `docs:`)                                             
  - ❌ Uses a slice prefix for a CI config change (non-slice infra → `chore:`)
