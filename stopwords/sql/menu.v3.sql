-- ftp://ftp.ntu.edu.tw/tmp/MySQL/tech-resources/articles/hierarchical-data.html

/*
drop table hr_menu;
drop table hr_menu_text;
select * from hr_menu;
select * from hr_menu_text;
 */
 
	CREATE  TABLE 
		IF NOT EXISTS
		hr_menu (
			 id_menu INT AUTO_INCREMENT PRIMARY KEY,
             menu_order INT,
             id_perfil INT,
			 -- name VARCHAR(20) NOT NULL,
			 lft INT NOT NULL,
			 rgt INT NOT NULL
		);
    CREATE  TABLE 
		IF NOT EXISTS
		hr_menu_text (
			 id_menu_text INT AUTO_INCREMENT PRIMARY KEY,
			 id_menu INT,
             menu_text VARCHAR(50) NOT NULL,
             lang VARCHAR(2) NOT NULL
		);
        
    CREATE TABLE 
		IF NOT EXISTS
		hr_menu_perfil(
			id_menu_perfil INT AUTO_INCREMENT PRIMARY KEY,
			id_menu INT NOT NULL,
			id_perfil int NOT NULL,
			enabled TINYINT(1) NOT NULL
	);
        

 
	DROP FUNCTION IF EXISTS getMenuId;
    DELIMITER $$
	CREATE FUNCTION `getMenuId`(pName varchar(128)) RETURNS INT
	BEGIN
		DECLARE  vId INT;
        SELECT a.id_menu
			INTO vId 
		FROM hr_menu  a
			inner join hr_menu_text b
				on a.id_menu=b.id_menu
        WHERE b.menu_text=pName;        
		RETURN vId;
	END$$
	DELIMITER ;
    
  -- Menu Get All
	DROP PROCEDURE IF EXISTS menu_getAll;
	DELIMITER $
	CREATE  PROCEDURE menu_getAll(pLang varchar(2))
	BEGIN
		SELECT a.id_menu,b.menu_text
		FROM hr_menu  a
			inner join hr_menu_text b
				on a.id_menu=b.id_menu
		where b.lang=pLang
		ORDER BY lft;
	END$
	DELIMITER ;
    
    -- List Nodes
	DROP PROCEDURE IF EXISTS menu_List;
	DELIMITER $
	CREATE  PROCEDURE menu_List(pLang varchar(2))
	BEGIN
		SELECT node.id_menu,CONCAT( REPEAT('    ', COUNT(parent.id_menu) - 1), c.menu_text) AS name
		FROM hr_menu AS node,	hr_menu AS parent,hr_menu_text AS c
		WHERE node.lft BETWEEN parent.lft AND parent.rgt
        and c.lang=pLang
         and node.id_menu=c.id_menu -- and parent.id_menu=c.id_menu
		GROUP BY node.id_menu
        ORDER BY node.lft;
	END$
	DELIMITER ;
    
    -- Retrieving a Full Tree
	DROP PROCEDURE IF EXISTS menu_getFullTree;
	DELIMITER $
	CREATE  PROCEDURE menu_getFullTree(id int,pLang varchar(2))
	BEGIN
		SELECT c.menu_text
		FROM hr_menu AS node,hr_menu AS parent,hr_menu_text AS c
		WHERE node.lft BETWEEN parent.lft AND parent.rgt
				AND node.id_menu=c.id_menu 
				AND parent.id_menu =id 
				AND c.lang=pLang
		ORDER BY node.lft;
	END$
	DELIMITER ;
    
 
    -- Finding all the Leaf Nodes
	DROP PROCEDURE IF EXISTS menu_getAllLeafNodes;
	DELIMITER $
	CREATE  PROCEDURE menu_getAllLeafNodes(pLang varchar(2))
	BEGIN
		SELECT c.menu_text
		FROM hr_menu node,hr_menu_text AS c
		WHERE node.rgt = node.lft + 1
			AND node.id_menu=c.id_menu 
            AND c.lang=pLang;
	END$
	DELIMITER ;

	-- Retrieving a Single Path
	DROP PROCEDURE IF EXISTS menu_getSinglePath;
	DELIMITER $
	CREATE  PROCEDURE menu_getSinglePath(id int,pLang varchar(2))
	BEGIN
		SELECT c.menu_text 
		FROM hr_menu AS node,hr_menu AS parent,hr_menu_text AS c
		WHERE node.lft BETWEEN parent.lft AND parent.rgt
			AND node.id_menu =id 
            AND parent.id_menu=c.id_menu 
             AND c.lang=pLang
		ORDER BY parent.lft;
	END$
	DELIMITER ;
    
    
     
    -- Finding the Depth of the Nodes
	DROP PROCEDURE IF EXISTS menu_getNodesDepth;
	DELIMITER $
	CREATE  PROCEDURE menu_getNodesDepth(pLang varchar(2))
	BEGIN
		SELECT node.lft,node.id_menu ,c.menu_text , (COUNT(parent.id_menu) - 1) AS depth
		FROM hr_menu AS node,
			 hr_menu AS parent,
             hr_menu_text AS c
		WHERE node.lft BETWEEN parent.lft AND parent.rgt
				AND node.id_menu=c.id_menu 
				AND c.lang=pLang
		GROUP BY node.id_menu 
		ORDER BY node.lft;
	END$
	DELIMITER ;
    
     
    -- Depth of a Sub-Tree
	DROP PROCEDURE IF EXISTS menu_getDepthSubTree;
	DELIMITER $
	CREATE  PROCEDURE menu_getDepthSubTree(id int,pLang varchar(2))
	BEGIN
     SELECT c.menu_text , (COUNT(parent.id_menu) - (sub_tree.depth + 1)) AS depth
		FROM hr_menu AS node,
			hr_menu AS parent,
			hr_menu AS sub_parent,
            hr_menu_text AS c,
			(
				SELECT node.id_menu, (COUNT(parent.id_menu) - 1) AS depth
				FROM hr_menu AS node,
				hr_menu AS parent
				WHERE node.lft BETWEEN parent.lft AND parent.rgt
				AND node.id_menu = id 
				GROUP BY node.id_menu
				ORDER BY node.lft
			)AS sub_tree
		WHERE node.lft BETWEEN parent.lft AND parent.rgt
			AND node.lft BETWEEN sub_parent.lft AND sub_parent.rgt
			AND sub_parent.id_menu = sub_tree.id_menu
            AND node.id_menu=c.id_menu 
			AND c.lang=pLang
		GROUP BY c.menu_text 
		ORDER BY node.lft;
		 
	END$
	DELIMITER ;
  
	-- Find the Immediate Subordinates of a Node
    
    DROP PROCEDURE IF EXISTS menu_getImmediateSubordinatesNode;
	DELIMITER $
	CREATE  PROCEDURE menu_getImmediateSubordinatesNode(id int,pLang varchar(2))
	BEGIN
    	SELECT c.menu_text, (COUNT(parent.id_menu) - (sub_tree.depth + 1)) AS depth
		FROM hr_menu AS node,
			hr_menu AS parent,
			hr_menu AS sub_parent,
            hr_menu_text AS c,
			(
				SELECT node.id_menu, (COUNT(parent.id_menu) - 1) AS depth
				FROM hr_menu AS node,
				hr_menu AS parent
				WHERE node.lft BETWEEN parent.lft AND parent.rgt
				AND node.id_menu = id 
				GROUP BY node.id_menu
				ORDER BY node.lft
			)AS sub_tree
		WHERE node.lft BETWEEN parent.lft AND parent.rgt
			AND node.lft BETWEEN sub_parent.lft AND sub_parent.rgt
			AND sub_parent.id_menu = sub_tree.id_menu
            AND node.id_menu=c.id_menu 
			AND c.lang=pLang
		GROUP BY c.menu_text
		HAVING depth <= 1
		ORDER BY node.lft;
    END$
	DELIMITER ;
    
    
    -- ----------------------------------------------------
    -- Add node Same level
    -- ----------------------------------------------------
    DROP PROCEDURE IF EXISTS menu_addNodeSameLevel;
	DELIMITER $
	CREATE  PROCEDURE menu_addNodeSameLevel(pId_menu int,pLang varchar(2),pName varchar(128))
	BEGIN
		DECLARE vErrorMessage varchar(1024);
        DECLARE myRight INT;
        DECLARE id INT;
        
        
        
        IF pId_menu =0 OR pId_menu IS NULL  THEN
			IF (SELECT COUNT(*) FROM hr_menu)=0 THEN
				INSERT INTO hr_menu(lft,rgt)
					VALUES(1,2);
				INSERT INTO hr_menu_text(id_menu,menu_text,lang )
					VALUES(LAST_INSERT_ID(),pName,pLang);
			ELSE	
				
				SET vErrorMessage =(SELECT getErrorMessage(pLang ,'A0011'));
				SIGNAL SQLSTATE VALUE 'A0011' SET MESSAGE_TEXT =vErrorMessage;
			END IF;
			
		END IF;                
		
        IF pId_menu >0  AND pId_menu IS NOT NULL THEN
			-- SELECT @myRight := rgt FROM hr_menu WHERE id_menu =pId_menu;
            SELECT rgt 
				INTO myRight 
            FROM hr_menu WHERE id_menu =pId_menu;
            
            

			UPDATE hr_menu SET rgt = rgt + 2 WHERE rgt > myRight;
			UPDATE hr_menu SET lft = lft + 2 WHERE lft > myRight;
			
			INSERT INTO hr_menu(lft, rgt) 
				VALUES( myRight + 1, myRight + 2);
			
            SET id=LAST_INSERT_ID();
        
			INSERT INTO hr_menu_text(id_menu,menu_text,lang )
			VALUES(id,pName,pLang);
            
            SELECT  id as id_menu, ROW_COUNT() row_count;	
		END IF;

	END$
	DELIMITER ;
    
    
    
-- ------------------------------------------------------------------
-- Add node child
-- If we instead want to add a node as a child of a node that 
-- has no existing children
-- ------------------------------------------------------------------

	DROP PROCEDURE IF EXISTS menu_addNodeChild;
	DELIMITER $
	CREATE  PROCEDURE menu_addNodeChild(pId_menu int,pLang varchar(2),pName varchar(128))
	BEGIN
		DECLARE myLeft INT;
		SET myLeft =(SELECT lft  FROM hr_menu		WHERE id_menu = pId_menu);

		UPDATE hr_menu SET rgt = rgt + 2 WHERE rgt > myLeft;
		UPDATE hr_menu SET lft = lft + 2 WHERE lft > myLeft;

		INSERT INTO hr_menu(lft, rgt) 
			VALUES(myLeft + 1, myLeft + 2);
            
        INSERT INTO hr_menu_text(id_menu,menu_text,lang )
        VALUES(LAST_INSERT_ID(),pName,pLang);    
        SELECT  ROW_COUNT() row_count;	

	END$
	DELIMITER ;

	-- Borrar Nodo
 
	DROP PROCEDURE IF EXISTS menu_deleteNode;
	DELIMITER $
	CREATE  PROCEDURE menu_deleteNode(pId_menu int)
	BEGIN
		DECLARE vCount INT;
        DECLARE myLeft INT;
        DECLARE myRight INT;
        DECLARE myWidth INT;
        SET vCount=0;

		SELECT myLeft = lft, myRight = rgt, myWidth = rgt - lft + 1
		FROM hr_menu
		WHERE id_menu= pId_menu;

		DELETE FROM hr_menu WHERE lft BETWEEN myLeft AND myRight;
        DELETE FROM hr_menu_text WHERE id_menu= pId_menu;
        SET  vCount=(SELECT  ROW_COUNT());	

		UPDATE hr_menu SET rgt = rgt - myWidth WHERE rgt > myRight;
		UPDATE hr_menu SET lft = lft - myWidth WHERE lft > myRight;
        
        SELECT  vCount row_count;	

 	END$
	DELIMITER ;

	-- DELETE NODE and Move Childs
    
    DROP PROCEDURE IF EXISTS menu_deleteNodeMoveChild;
	DELIMITER $
	CREATE  PROCEDURE menu_deleteNodeMoveChild(pId_menu int)
	BEGIN

		SELECT @myLeft := lft, @myRight := rgt, @myWidth := rgt - lft + 1
		FROM hr_menu
		WHERE id_menu = pId_menu;

		DELETE FROM hr_menu WHERE lft = @myLeft;
        DELETE FROM hr_menu_text WHERE id_menu= pId_menu;
        SELECT  ROW_COUNT() row_count;	

		UPDATE hr_menu SET rgt = rgt - 1, lft = lft - 1 WHERE lft BETWEEN @myLeft AND @myRight;
		UPDATE hr_menu SET rgt = rgt - 2 WHERE rgt > @myRight;
		UPDATE hr_menu SET lft = lft - 2 WHERE lft > @myRight;

	END$
	DELIMITER ;
    
    -- ----------------------------------------------------
    -- update node 
    -- ----------------------------------------------------
    DROP PROCEDURE IF EXISTS menu_updateNode;
	DELIMITER $
	CREATE  PROCEDURE menu_updateNode(pId_menu int,pLang varchar(2),pName varchar(128))
	BEGIN
		UPDATE hr_menu_text
		SET 
			menu_text=pName
		WHERE id_menu= pId_menu and lang=pLang;
        SELECT  ROW_COUNT() row_count;	
	END$
	DELIMITER ;

/* 

 -- menu_GetMenuUsuarioFull
 
	SELECT node.name,node.id_menu,
	 (COUNT(parent.name) - 1) AS depth  , (select ((rgt-lft)-1) from  menu  where id_menu=node.id_menu) as leaf 
	 
	FROM  	menu AS parent , menu AS node	  
			-- left join UsuarioMenu on node.IdNodo = UsuarioMenu.IdNodo
	WHERE (node.lft BETWEEN parent.lft AND parent.rgt) 
	GROUP by node.name,node.id_menu -- ,   node.href , node.lft -- ,UsuarioMenu.IdUsuario,UsuarioMenu.Enabled
	Order by node.Lft
 

    
-- Menu de usuario
    
 
    
    ALTER PROCEDURE [dbo].[menu_AdjacencyListFullMenu] 
	@idUsuario int
	AS
		SELECT A.IdNodo,
			   B.IdNodo AS parent,
			   isnull(UsuarioMenu.IdUsuario, 0) as IdUsuario , 	
			   A.Name,A.href,isnull(UsuarioMenu.Enabled, 0) as Enabled 
		FROM Menu AS A
		LEFT JOIN Menu AS B
		  ON B.lft = (SELECT MAX(C.lft)
					 FROM Menu AS C
					 WHERE A.lft > C.lft
					   AND A.lft < C.rgt)
	left join UsuarioMenu on A.IdNodo = UsuarioMenu.IdNodo and UsuarioMenu.IdUsuario=@idUsuario
	order by A.Lft
*/


	SELECT getMenuId('END') id_menu;					-- OK
    CALL menu_getAll('ES');								-- OK
    CALL menu_List('ES'); 								-- OK
    CALL menu_getFullTree(1,'ES');						-- OK
    CALL menu_getAllLeafNodes('ES');					-- OK
    CALL menu_getSinglePath(1,'ES');					-- OK
    CALL menu_getNodesDepth('ES');						-- OK
	CALL menu_getDepthSubTree(1,'ES');					-- OK
    CALL menu_getImmediateSubordinatesNode(1,'ES');		-- OK
    CALL menu_addNodeSameLevel (1,'EN','END'); 			-- OK
    CALL menu_addNodeChild(1,'EN','SUB Test 1');		-- OK
    CALL menu_deleteNodeMoveChild(2);					-- OK
    CALL menu_deleteNode (9);							-- OK
    
    
   
    
	select * from hr_menu;
	select * from hr_menu_text;

	truncate table hr_menu;
	truncate table hr_menu_text;
    
    
    
		CALL menu_addNodeSameLevel (NULL,'ES','Computers');
        CALL menu_addNodeSameLevel (1,'ES','Camera');
		CALL menu_addNodeChild (1,'ES','Laptops');
        
		CALL menu_addNodeChild (1,'ES','Desktops');
        CALL menu_addNodeChild (3,'ES','Intel');
		CALL menu_addNodeSameLevel (1,'ES','Consoles');
        
        CALL menu_addNodeChild (2,'ES','Apple');
        CALL menu_addNodeChild (2,'ES','IOS');
        CALL menu_addNodeChild (2,'ES','IPhone');
        
        CALL menu_addNodeChild (5,'ES','PS3');
        CALL menu_addNodeChild (4,'ES','AMD');
        CALL menu_addNodeChild (7,'ES','Test');
        CALL menu_addNodeChild (12,'ES','Test 2');
        CALL menu_addNodeChild (6,'ES','Apple 2');
        
		
		CALL menu_addNodeChild (1,'ES','Sub Item 1');
		CALL menu_addNodeChild (2,'ES','Sub Item 1');
		CALL menu_addNodeChild (3,'ES','Sub Item 1');
		CALL menu_addNodeChild (4,'ES','Sub Item 1');
		
		CALL menu_addNodeChild (1,'ES','Sub Item 2');
		CALL menu_addNodeChild (2,'ES','Sub Item 2');
		CALL menu_addNodeChild (3,'ES','Sub Item 2');
		CALL menu_addNodeChild (4,'ES','Sub Item 2');
        
		CALL menu_addNodeChild (1,'ES','Sub Item 3');
        
		CALL menu_addNodeChild (5,'ES','Sub Sub Item 2');
   
        