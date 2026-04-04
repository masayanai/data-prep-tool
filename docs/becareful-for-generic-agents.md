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
                                                                                                                           
  3. Commit conventions
  Align `AGENTS.md` and boot files with the commit message style you want (e.g. conventional commits). Agents follow what is documented.
                                                                                                                           
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
                                                                   
  7. Boot list must match reality
  Every path named in boot files (`CLAUDE.md`, `AGENTS.md`, etc.) must exist. Start minimal and add documents as you create them.           
                                                                                                                           
  ---                                                              
  Short version: The behavioral infrastructure (AGENTS.md, AI_RULES, review templates, issue/PR templates,
  ENGINEERING_PRACTICES) ports cleanly. Boot files and authority maps need adaptation. Domain-specific architecture starts fresh.