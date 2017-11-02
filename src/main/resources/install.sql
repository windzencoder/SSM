CREATE TABLE `ssm_crud`.`tbl_emp` (
  `emp_id` INT NOT NULL AUTO_INCREMENT,
  `emp_name` VARCHAR(255) NOT NULL,
  `gender` CHAR(1) NULL,
  `email` VARCHAR(255) NULL,
  PRIMARY KEY (`emp_id`));

  CREATE TABLE `ssm_crud`.`tbl_dept` (
  `dept_id` INT(11) NOT NULL,
  `dept_name` VARCHAR(255) NULL,
  PRIMARY KEY (`dept_id`));

  
  ALTER TABLE `ssm_crud`.`tbl_emp` 
ADD COLUMN `d_id` INT(11) NULL AFTER `email`,
ADD INDEX `fk_emp_dept_idx` (`d_id` ASC);
ALTER TABLE `ssm_crud`.`tbl_emp` 
ADD CONSTRAINT `fk_emp_dept`
  FOREIGN KEY (`d_id`)
  REFERENCES `ssm_crud`.`tbl_dept` (`dept_id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;
