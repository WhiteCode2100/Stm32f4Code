/* Entry Point */
ENTRY(main)

/* Specify the memory areas */
MEMORY
{
  FLASH (rx)      : ORIGIN = 0x08000000, LENGTH = 1024K
  RAM (xrw)      : ORIGIN = 0x20000000, LENGTH = 128K
  CCMRAM (rw)      : ORIGIN = 0x10000000, LENGTH = 64K
}

SECTIONS
{
  .vector_table ORIGIN(FLASH) :
  {
    LONG(ORIGIN(RAM) + LENGTH(RAM));
    
    KEEP(\*(.vector_table));
  } > FLASH

  .text ADDR(.vector_table) + SIZEOF(.vector_table):
  {
    \*(.text .text.\*);
  } >FLASH
}