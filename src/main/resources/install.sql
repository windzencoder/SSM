CREATE TABLE `ssm_crud`.`tbl_dept` (
  `dept_id` INT(11) NOT NULL AUTO_INCREMENT,
  `dept_name` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`dept_id`));
  
  CREATE TABLE `ssm_crud`.`tbl_emp` (
  `emp_id` INT(11) NOT NULL,
  `emp_name` VARCHAR(255) NOT NULL,
  `gender` CHAR(1) NULL,
  `email` VARCHAR(255) NULL,
  `d_id` INT(11) NULL,
  PRIMARY KEY (`emp_id`),
  INDEX `fk_empt_dept_idx` (`d_id` ASC),
  CONSTRAINT `fk_empt_dept`
    FOREIGN KEY (`d_id`)
    REFERENCES `ssm_crud`.`tbl_dept` (`dept_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

    ALTER TABLE `ssm_crud`.`tbl_emp` 
CHANGE COLUMN `emp_id` `emp_id` INT(11) NOT NULL AUTO_INCREMENT ;
  
