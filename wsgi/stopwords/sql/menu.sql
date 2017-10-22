/*
http://dba.stackexchange.com/questions/89051/stored-procedure-to-update-an-adjacency-model-to-nested-sets-model
http://mikehillyer.com/articles/managing-hierarchical-data-in-mysql/
ftp://ftp.ntu.edu.tw/tmp/MySQL/tech-resources/articles/hierarchical-data.html

Mover Nodo
http://stackoverflow.com/questions/889527/move-node-in-nested-set

github
https://github.com/developerworks/hierarchy-data-closure-table

http://we-rc.com/blog/2015/07/19/nested-set-model-practical-examples-part-i
*/



CREATE TABLE `tree_map` (
  `node_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `lft` smallint(5) unsigned NOT NULL,
  `rgt` smallint(5) unsigned NOT NULL,
  `parent_id` smallint(5) unsigned NOT NULL,
  PRIMARY KEY (`node_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE VIEW `vw_lftrgt` AS select `tree_map`.`lft` AS `lft` from `tree_map` union select `tree_map`.`rgt` AS `rgt` from `tree_map`;

CREATE TABLE `tree_content` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `node_id` smallint(5) unsigned NOT NULL,
  `lang` char(2) NOT NULL DEFAULT 'en',
  `name` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- --------------------------------------------------------------------------------
-- Routine DDL
-- Note: comments before and after the routine body will not be stored by the server
-- --------------------------------------------------------------------------------
DROP PROCEDURE IF EXISTS   `r_tree_traversal_insert`;
DELIMITER $$
CREATE PROCEDURE `r_tree_traversal_insert`(
  IN pnode_id INT,
  IN pparent_id INT,
  OUT pnew_node INT
)
BEGIN
		DECLARE new_lft, new_rgt, width, has_leafs, superior, superior_parent, old_lft, old_rgt, parent_rgt, subtree_size SMALLINT;
        
        SELECT rgt INTO new_lft FROM tree_map WHERE node_id = pparent_id;
        UPDATE tree_map SET rgt = rgt + 2 WHERE rgt >= new_lft;
        UPDATE tree_map SET lft = lft + 2 WHERE lft > new_lft;
        INSERT INTO tree_map (lft, rgt, parent_id) VALUES (new_lft, (new_lft + 1), pparent_id);
		SELECT LAST_INSERT_ID()
			INTO pnew_node;
        SELECT pnew_node node_id;    
END        

        
DROP PROCEDURE IF EXISTS   `r_tree_traversal`;
DELIMITER $$
CREATE PROCEDURE `r_tree_traversal`(
  IN ptask_type VARCHAR(10),
  IN pnode_id INT,
  IN pparent_id INT
)
BEGIN
  DECLARE new_lft, new_rgt, width, has_leafs, superior, superior_parent, old_lft, old_rgt, parent_rgt, subtree_size SMALLINT;

  CASE ptask_type

    WHEN 'delete' THEN

        SELECT lft, rgt, (rgt - lft), (rgt - lft + 1), parent_id 
		  INTO new_lft, new_rgt, has_leafs, width, superior_parent 
		  FROM tree_map WHERE node_id = pnode_id;

		DELETE FROM tree_content WHERE node_id = pnode_id;

        IF (has_leafs = 1) THEN
          DELETE FROM tree_map WHERE lft BETWEEN new_lft AND new_rgt;
          UPDATE tree_map SET rgt = rgt - width WHERE rgt > new_rgt;
          UPDATE tree_map SET lft = lft - width WHERE lft > new_rgt;
        ELSE
          DELETE FROM tree_map WHERE lft = new_lft;
          UPDATE tree_map SET rgt = rgt - 1, lft = lft - 1, parent_id = superior_parent 
		   WHERE lft BETWEEN new_lft AND new_rgt;
          UPDATE tree_map SET rgt = rgt - 2 WHERE rgt > new_rgt;
          UPDATE tree_map SET lft = lft - 2 WHERE lft > new_rgt;
        END IF;

    WHEN 'move' THEN
    
		IF (pnode_id != pparent_id) THEN
        CREATE TEMPORARY TABLE IF NOT EXISTS working_tree_map
        (
          `node_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
          `lft` smallint(5) unsigned DEFAULT NULL,
          `rgt` smallint(5) unsigned DEFAULT NULL,
          `parent_id` smallint(5) unsigned NOT NULL,
          PRIMARY KEY (`node_id`)
        );
        
		-- put subtree into temporary table
        INSERT INTO working_tree_map (node_id, lft, rgt, parent_id)
			 SELECT t1.node_id, 
					(t1.lft - (SELECT MIN(lft) FROM tree_map WHERE node_id = pnode_id)) AS lft,
					(t1.rgt - (SELECT MIN(lft) FROM tree_map WHERE node_id = pnode_id)) AS rgt,
					t1.parent_id
			   FROM tree_map AS t1, tree_map AS t2
			  WHERE t1.lft BETWEEN t2.lft AND t2.rgt 
				AND t2.node_id = pnode_id;

        DELETE FROM tree_map WHERE node_id IN (SELECT node_id FROM working_tree_map);

        SELECT rgt INTO parent_rgt FROM tree_map WHERE node_id = pparent_id;
        SET subtree_size = (SELECT (MAX(rgt) + 1) FROM working_tree_map);
		
		-- make a gap in the tree
        UPDATE tree_map
          SET lft = (CASE WHEN lft > parent_rgt THEN lft + subtree_size ELSE lft END),
              rgt = (CASE WHEN rgt >= parent_rgt THEN rgt + subtree_size ELSE rgt END)
        WHERE rgt >= parent_rgt;

        INSERT INTO tree_map (node_id, lft, rgt, parent_id)
             SELECT node_id, lft + parent_rgt, rgt + parent_rgt, parent_id
               FROM working_tree_map;
        
		-- close gaps in tree
        UPDATE tree_map
           SET lft = (SELECT COUNT(*) FROM vw_lftrgt AS v WHERE v.lft <= tree_map.lft),
               rgt = (SELECT COUNT(*) FROM vw_lftrgt AS v WHERE v.lft <= tree_map.rgt);
        
        DELETE FROM working_tree_map;
        UPDATE tree_map SET parent_id = pparent_id WHERE node_id = pnode_id;
		END IF;

    WHEN 'order' THEN

        SELECT lft, rgt, (rgt - lft + 1), parent_id INTO old_lft, old_rgt, width, superior
          FROM tree_map WHERE node_id = pnode_id;

        -- is parent 
        SELECT parent_id INTO superior_parent FROM tree_map WHERE node_id = pparent_id;

        IF (superior = superior_parent) THEN
          SELECT (rgt + 1) INTO new_lft FROM tree_map WHERE node_id = pparent_id;
        ELSE
          SELECT (lft + 1) INTO new_lft FROM tree_map WHERE node_id = pparent_id;
        END IF;

	    IF (new_lft != old_lft) THEN
		  CREATE TEMPORARY TABLE IF NOT EXISTS working_tree_map
        (
          `node_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
          `lft` smallint(5) unsigned DEFAULT NULL,
          `rgt` smallint(5) unsigned DEFAULT NULL,
          `parent_id` smallint(5) unsigned NOT NULL,
          PRIMARY KEY (`node_id`)
        );

	     INSERT INTO working_tree_map (node_id, lft, rgt, parent_id)
            SELECT t1.node_id,
			  	   (t1.lft - (SELECT MIN(lft) FROM tree_map WHERE node_id = pnode_id)) AS lft,
				   (t1.rgt - (SELECT MIN(lft) FROM tree_map WHERE node_id = pnode_id)) AS rgt,
				   t1.parent_id
			  FROM tree_map AS t1, tree_map AS t2
			 WHERE t1.lft BETWEEN t2.lft AND t2.rgt AND t2.node_id = pnode_id;
            
       DELETE FROM tree_map WHERE node_id IN (SELECT node_id FROM working_tree_map);

       IF(new_lft < old_lft) THEN -- move up
          UPDATE tree_map SET lft = lft + width WHERE lft >= new_lft AND lft < old_lft;
          UPDATE tree_map SET rgt = rgt + width WHERE rgt > new_lft AND rgt < old_rgt;
          UPDATE working_tree_map SET lft = new_lft + lft, rgt = new_lft + rgt;
       END IF;

       IF(new_lft > old_lft) THEN -- move down
            UPDATE tree_map SET lft = lft - width WHERE lft > old_lft AND lft < new_lft;
            UPDATE tree_map SET rgt = rgt - width WHERE rgt > old_rgt AND rgt < new_lft;
            UPDATE working_tree_map SET lft = (new_lft - width) + lft, rgt = (new_lft - width) + rgt;
       END IF;

       INSERT INTO tree_map (node_id, lft, rgt, parent_id)
            SELECT node_id, lft, rgt, parent_id
              FROM working_tree_map;
            
       DELETE FROM working_tree_map;
	   END IF;
  END CASE;

END
	-- --------------------------------------------------------------------------------
	-- Routine DDL
	-- Note: comments before and after the routine body will not be stored by the server
	-- --------------------------------------------------------------------------------
	DROP PROCEDURE IF EXISTS   `r_return_tree_depth`;
	DELIMITER $$
	CREATE DEFINER=`root`@`localhost` PROCEDURE `r_return_tree_depth`(

	  IN plang CHAR(2)

	)
	BEGIN

	  SELECT node.node_id, (COUNT(parent.node_id) - 1) AS depth,
	 (SELECT name FROM tree_content WHERE node_id = node.node_id AND lang = plang) AS name
		FROM tree_map AS node, tree_map AS parent
	   WHERE node.lft BETWEEN parent.lft AND parent.rgt
	   GROUP BY node.node_id
	   ORDER BY node.lft;

	END

-- --------------------------------------------------------------------------------
-- Routine DDL
-- Note: comments before and after the routine body will not be stored by the server
-- --------------------------------------------------------------------------------
DROP PROCEDURE IF EXISTS   `r_return_tree`;
DELIMITER $$
CREATE PROCEDURE `r_return_tree`(
  IN pedited INT,
  IN plang CHAR(2)
)
BEGIN
-- Mostly for HTML select boxes
  IF pedited IS NULL THEN
    SELECT n.node_id,
      CONCAT( REPEAT(' . . ', COUNT(CAST(p.node_id AS CHAR)) - 1), 
      (SELECT name FROM tree_content WHERE node_id = n.node_id AND lang = plang)) AS name
    FROM tree_map AS n, tree_map AS p
    WHERE (n.lft BETWEEN p.lft AND p.rgt)
    GROUP BY node_id
    ORDER BY n.lft;
  ELSE
    SELECT n.node_id,
      CONCAT( REPEAT(' . . ', COUNT(CAST(p.node_id AS CHAR)) - 1), 
      (SELECT name FROM tree_content WHERE node_id = n.node_id AND lang = plang)) AS name
    FROM tree_map AS n, tree_map AS p
    WHERE (n.lft BETWEEN p.lft AND p.rgt) AND n.node_id != pedited
    GROUP BY node_id
    ORDER BY n.lft;

  END IF;
       
END

-- --------------------------------------------------------------------------------
-- Routine DDL
-- Note: comments before and after the routine body will not be stored by the server
-- --------------------------------------------------------------------------------
DROP PROCEDURE IF EXISTS   `r_return_subtree`;
DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `r_return_subtree`(
  IN pnode_id INT,
  IN plang CHAR(2)
)
BEGIN
  SELECT node.node_id, 
		     (COUNT(parent.node_id) - (sub_tree.depth + 1)) AS depth,
		     (SELECT name FROM tree_content WHERE node_id = node.node_id AND lang = plang) AS name
    FROM tree_map AS node,
         tree_map AS parent,
         tree_map AS sub_parent,
  (SELECT node.node_id, (COUNT(parent.node_id) - 1) AS depth
    FROM tree_map AS node,
		     tree_map AS parent
	 WHERE node.lft BETWEEN parent.lft AND parent.rgt
		 AND node.node_id = pnode_id
	 GROUP BY node.node_id
	 ORDER BY node.lft) AS sub_tree
   WHERE node.lft BETWEEN parent.lft AND parent.rgt
	   AND node.lft BETWEEN sub_parent.lft AND sub_parent.rgt
	   AND sub_parent.node_id = sub_tree.node_id
   GROUP BY node.node_id
   ORDER BY node.lft;
END

-- --------------------------------------------------------------------------------
-- Routine DDL
-- Note: comments before and after the routine body will not be stored by the server
-- --------------------------------------------------------------------------------
DROP PROCEDURE IF EXISTS   `r_return_path`;
DELIMITER $$
CREATE PROCEDURE `r_return_path`(
  IN pnode_id INT,
  IN plang CHAR(2)
)
BEGIN
  SELECT p.node_id, name
    FROM tree_map AS n, tree_map AS p
    LEFT JOIN tree_content AS tc ON p.node_id = tc.node_id 
   WHERE n.lft BETWEEN p.lft AND p.rgt
     AND n.node_id = pnode_id
     AND lang = plang
   ORDER BY p.lft;
END

-- --------------------------------------------------------------------------------
-- Routine DDL
-- Note: comments before and after the routine body will not be stored by the server
-- --------------------------------------------------------------------------------
DROP PROCEDURE IF EXISTS   `r_insert_node`;
DELIMITER $$
CREATE PROCEDURE `r_insert_node`(
  IN pnode_id INT,
  IN pitem_name VARCHAR(128),
  IN plang CHAR(2)
)
BEGIN
    DECLARE  vNode_id int;
    
	CALL r_tree_traversal_insert(NULL, 1,vNode_id);
    INSERT INTO tree_content (node_id, name) VALUES (pnode_id ,pitem_name);
END

-- INIT 
	truncate table tree_content;
	truncate table tree_map;

 INSERT INTO `tree_map` (`node_id`,`lft`,`rgt`,`parent_id`) VALUES (1, 1, 2, 0);    
 INSERT INTO `tree_content` (`node_id`,`name`) VALUES (1,'Home');

-- 
	CALL r_return_tree(0, 'EN');
    CALL r_return_path(1, 'EN');
    CALL r_return_subtree(0, 'EN');
    
    

-- Insertar Nodo    
	CALL r_insert_node(1,'Item 1','EN');
    CALL r_insert_node(1,'Item 2','EN');
    CALL r_insert_node(3,'Test 2.1','EN');
    CALL r_insert_node(3,'Test 2.2','EN');
    CALL r_insert_node(4,'Test 2.2.1','EN');
    CALL r_insert_node(1,'Item 3','EN');

-- Borrar Nodo
	CALL r_tree_traversal('delete', 4, NULL);    
 
/*
select * from tree_map 
node_id	 lft	rgt		parent_id
1		  1		4		0
2		  2		3		1
3		  4		5		1

select * from tree_content;
id	 node_id   lang		name
1		1		en		Home
2		1		en		Test


*/			
 
 SELECT n.node_id  , (SELECT name from tree_content where id=n.node_id and lang='en') as name
    FROM tree_map AS n, tree_map AS p
    WHERE (n.lft BETWEEN p.lft AND p.rgt)
    GROUP BY node_id
    ORDER BY n.lft;



  SELECT n.node_id,
  
  ,   CONCAT( REPEAT(' . . ', COUNT(CAST(p.node_id AS CHAR)) - 1), 
      (SELECT count(1) FROM tree_content WHERE node_id = n.node_id AND lang = 'en')) AS name
      
    FROM tree_map AS n, tree_map AS p
    WHERE (n.lft BETWEEN p.lft AND p.rgt)
    GROUP BY node_id
    ORDER BY n.lft;
    
    
    
    
    SELECT n.node_id,
      CONCAT( REPEAT(' . . ', COUNT(CAST(p.node_id AS CHAR)) - 1), 
      (SELECT name FROM tree_content WHERE node_id = n.node_id AND lang = plang)) AS name
    FROM tree_map AS n, tree_map AS p
    WHERE (n.lft BETWEEN p.lft AND p.rgt) AND n.node_id != pedited
    GROUP BY node_id
    ORDER BY n.lft;

