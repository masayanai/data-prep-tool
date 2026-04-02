---                                                                                                                      
  What to Be Careful About                                                                                                 
                                                                   
  1. Boot file reading order
  CLAUDE.md (and equivalents) tell agents exactly which files to read on boot, in what order. When you adapt these for the 
  new project, every document named in the reading order must exist. A missing file silently breaks the agent's context    
  loading. Build the reading list incrementally — start with just AGENTS.md, ARCHITECTURE_PRINCIPLES.md, and AI_RULES.md   
  and add others as they exist.                                                                                            
                                                                   
  2. Authority track wiring
  AUTHORITY_ORDER.md defines which document wins in a conflict. When you adapt it, every document you name in the hierarchy
   must actually exist and must be consistent with its assigned authority level. An authority document that doesn't exist  
  yet should simply not appear in the hierarchy yet — don't list placeholders.
                                                                                                                           
  3. Skill commit prefix convention                                
  The skills (especially pr-summary-and-commit) hardcode the slice-XX RED/GREEN/REFACTOR commit convention from this
  project. Decide the new project's commit convention first and update the skill before agents start using it, otherwise   
  commit messages will be inconsistent from the first commit.
                                                                                                                           
  4. Two-track authority model (from ADR-0035)                     
  This project separates Design Authority documents (what the system is) from Operational Constraint documents (how agents
  behave). This is worth carrying explicitly into the new project's AUTHORITY_ORDER.md. It prevents a common problem where 
  an AI agent treats a process document as an architectural decision or vice versa.
                                                                                                                           
  5. AI_RULES.md operational permissions section                                                                           
  The permissions matrix (what agents may read/write/execute/push) is partially generic but the prohibited actions list
  references automation-platform specifics (e.g., "do not write directly to external systems"). Review and rewrite the     
  prohibited actions for the new project's risk surface before giving agents access.
                                                                                                                           
  6. .claude/ settings                                                                                                     
  Check .claude/settings.json for any hooks or tool permissions that are automation-platform-specific. These run
  automatically and could behave unexpectedly in a new context.                                                            
                                                                   
  7. Don't port the snapshot — seed it                                                                                     
  Use docs/ai/templates/CONTEXT_SNAPSHOT_TEMPLATE.md to write a v1 snapshot for the new project rather than copying a
  versioned snapshot from this one. The snapshot is the single most important file for agent context continuity — starting 
  from a clean, accurate seed is worth the extra effort.           
                                                                                                                           
  ---                                                              
  Short version: The behavioral infrastructure (AGENTS.md, skills, protocols, templates, issue/PR templates,
  ENGINEERING_PRACTICES) ports cleanly. The boot files and authority maps need adaptation. Everything domain-specific      
  (ADRs, architecture docs, snapshots) starts fresh.