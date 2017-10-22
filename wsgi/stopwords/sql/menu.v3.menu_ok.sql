-- ftp://ftp.ntu.edu.tw/tmp/MySQL/tech-resources/articles/hierarchical-data.html

-- nested_category -> menu
-- category_id	-> id_menu


	CREATE  TABLE 
		IF NOT EXISTS
		hr_menu (
			 id_menu INT AUTO_INCREMENT PRIMARY KEY,
			 name VARCHAR(20) NOT NULL,
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

select * from hr_menu_text

 
  -- Menu Get All
	DROP PROCEDURE IF EXISTS menu_getAll;
	DELIMITER $
	CREATE  PROCEDURE menu_getAll()
	BEGIN
		SELECT *
		FROM hr_menu 
		ORDER BY lft;
	END$
	DELIMITER ;
    
    -- List Nodes
	DROP PROCEDURE IF EXISTS menu_List;
	DELIMITER $
	CREATE  PROCEDURE menu_List()
	BEGIN
		SELECT CONCAT( REPEAT('        ', COUNT(parent.name) - 1), node.name) AS name
		FROM hr_menu AS node,	hr_menu AS parent
		WHERE node.lft BETWEEN parent.lft AND parent.rgt
		GROUP BY node.name
		ORDER BY node.lft;
	END$
	DELIMITER ;

    DROP FUNCTION IF EXISTS getMenuId;
    DELIMITER $$
	CREATE FUNCTION `getMenuId`(pName varchar(128)) RETURNS INT
	BEGIN
		DECLARE  vId INT;
		SELECT id_menu
			INTO vId 
		FROM hr_menu 
		WHERE name =pName;
		RETURN vId;
	END$$
	DELIMITER ;
    
    -- Retrieving a Full Tree
	DROP PROCEDURE IF EXISTS menu_getFullTree;
	DELIMITER $
	CREATE  PROCEDURE menu_getFullTree(id int)
	BEGIN
		SELECT node.name
		FROM hr_menu AS node,
		hr_menu AS parent
		WHERE node.lft BETWEEN parent.lft AND parent.rgt
		AND parent.id_menu =id 
		ORDER BY node.lft;
	END$
	DELIMITER ;
    
    -- Finding all the Leaf Nodes
	DROP PROCEDURE IF EXISTS menu_getAllLeafNodes;
	DELIMITER $
	CREATE  PROCEDURE menu_getAllLeafNodes()
	BEGIN
		SELECT name
		FROM hr_menu
		WHERE rgt = lft + 1;
	END$
	DELIMITER ;

	-- Retrieving a Single Path
	DROP PROCEDURE IF EXISTS menu_getSinglePath;
	DELIMITER $
	CREATE  PROCEDURE menu_getSinglePath(id int)
	BEGIN
		SELECT parent.name
		FROM hr_menu AS node,hr_menu AS parent
		WHERE node.lft BETWEEN parent.lft AND parent.rgt
		AND node.id_menu =id 
		ORDER BY parent.lft;
	END$
	DELIMITER ;
    
     
    -- Finding the Depth of the Nodes
	DROP PROCEDURE IF EXISTS menu_getNodesDepth;
	DELIMITER $
	CREATE  PROCEDURE menu_getNodesDepth()
	BEGIN
		SELECT node.name, (COUNT(parent.name) - 1) AS depth
		FROM hr_menu AS node,
			 hr_menu AS parent
		WHERE node.lft BETWEEN parent.lft AND parent.rgt
		GROUP BY node.name
		ORDER BY node.lft;
	END$
	DELIMITER ;
	
    -- Depth of a Sub-Tree
	DROP PROCEDURE IF EXISTS menu_getDepthSubTree;
	DELIMITER $
	CREATE  PROCEDURE menu_getDepthSubTree(id int)
	BEGIN
     
		SELECT node.name, (COUNT(parent.name) - (sub_tree.depth + 1)) AS depth
		FROM hr_menu AS node,
			hr_menu AS parent,
			hr_menu AS sub_parent,
			(
				SELECT node.name, (COUNT(parent.name) - 1) AS depth
				FROM hr_menu AS node,
				hr_menu AS parent
				WHERE node.lft BETWEEN parent.lft AND parent.rgt
				AND node.id_menu = id 
				GROUP BY node.name
				ORDER BY node.lft
			)AS sub_tree
		WHERE node.lft BETWEEN parent.lft AND parent.rgt
			AND node.lft BETWEEN sub_parent.lft AND sub_parent.rgt
			AND sub_parent.name = sub_tree.name
		GROUP BY node.name
		ORDER BY node.lft;
		 
	END$
	DELIMITER ;
  
	-- Find the Immediate Subordinates of a Node
    
    DROP PROCEDURE IF EXISTS menu_getImmediateSubordinatesNode;
	DELIMITER $
	CREATE  PROCEDURE menu_getImmediateSubordinatesNode(id int)
	BEGIN
    	SELECT node.name, (COUNT(parent.name) - (sub_tree.depth + 1)) AS depth
		FROM hr_menu AS node,
			hr_menu AS parent,
			hr_menu AS sub_parent,
			(
				SELECT node.name, (COUNT(parent.name) - 1) AS depth
				FROM hr_menu AS node,
				hr_menu AS parent
				WHERE node.lft BETWEEN parent.lft AND parent.rgt
				AND node.id_menu = id 
				GROUP BY node.name
				ORDER BY node.lft
			)AS sub_tree
		WHERE node.lft BETWEEN parent.lft AND parent.rgt
			AND node.lft BETWEEN sub_parent.lft AND sub_parent.rgt
			AND sub_parent.name = sub_tree.name
		GROUP BY node.name
		HAVING depth <= 1
		ORDER BY node.lft;
    END$
	DELIMITER ;
    -- ----------------------------------------------------
    -- Add node Same level
    -- ----------------------------------------------------
    DROP PROCEDURE IF EXISTS menu_addNodeSameLevel;
	DELIMITER $
	CREATE  PROCEDURE menu_addNodeSameLevel(pId_menu int,pName varchar(128))
	BEGIN
    
		SELECT @myRight := rgt FROM hr_menu
		WHERE id_menu =pId_menu;

		UPDATE hr_menu SET rgt = rgt + 2 WHERE rgt > @myRight;
		UPDATE hr_menu SET lft = lft + 2 WHERE lft > @myRight;

		INSERT INTO hr_menu(name, lft, rgt) 
			VALUES(pName , @myRight + 1, @myRight + 2);

	END$
	DELIMITER ;
    
-- ------------------------------------------------------------------
-- Add node child
-- If we instead want to add a node as a child of a node that 
-- has no existing children
-- ------------------------------------------------------------------

	DROP PROCEDURE IF EXISTS menu_addNodeChild;
	DELIMITER $
	CREATE  PROCEDURE menu_addNodeChild(pId_menu int,pName varchar(128))
	BEGIN

		SELECT @myLeft := lft FROM hr_menu
		WHERE id_menu = pId_menu;

		UPDATE hr_menu SET rgt = rgt + 2 WHERE rgt > @myLeft;
		UPDATE hr_menu SET lft = lft + 2 WHERE lft > @myLeft;

		INSERT INTO hr_menu(name, lft, rgt) 
			VALUES(pName, @myLeft + 1, @myLeft + 2);

	END$
	DELIMITER ;

	-- Borrar Nodo
 
	DROP PROCEDURE IF EXISTS menu_deleteNode;
	DELIMITER $
	CREATE  PROCEDURE menu_deleteNode(pId_menu int)
	BEGIN

		SELECT @myLeft := lft, @myRight := rgt, @myWidth := rgt - lft + 1
		FROM hr_menu
		WHERE id_menu= pId_menu;

		DELETE FROM hr_menu WHERE lft BETWEEN @myLeft AND @myRight;

		UPDATE hr_menu SET rgt = rgt - @myWidth WHERE rgt > @myRight;
		UPDATE hr_menu SET lft = lft - @myWidth WHERE lft > @myRight;

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

		UPDATE hr_menu SET rgt = rgt - 1, lft = lft - 1 WHERE lft BETWEEN @myLeft AND @myRight;
		UPDATE hr_menu SET rgt = rgt - 2 WHERE rgt > @myRight;
		UPDATE hr_menu SET lft = lft - 2 WHERE lft > @myRight;

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
    
    CREATE TABLE [dbo].[UsuarioMenu](
		[IdUsuario] [int] NOT NULL,
		[IdNodo] [int] NOT NULL,
		[Enabled] [bit] NOT NULL
	) ON [PRIMARY]
    
    
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

	SELECT getMenuId('ELECTRONICS') id_menu;	
    CALL menu_getAll();
    CALL menu_getFullTree(1);
    CALL menu_getAllLeafNodes();
    CALL menu_getSinglePath(8);
    CALL menu_getNodesDepth();
    CALL menu_List();
	CALL menu_getDepthSubTree(6);
    CALL menu_getImmediateSubordinatesNode(6);
    CALL menu_addNodeSameLevel (1,'OK SAME LEVEL OK');
    CALL menu_addNodeChild(13,'SUB LEVEL');
    CALL menu_deleteNode (13);
    CALL menu_deleteNodeMoveChild(15);
    

/*
INSERT INTO menu
VALUES(1,'ELECTRONICS',1,20),(2,'TELEVISIONS',2,9),(3,'TUBE',3,4),
(4,'LCD',5,6),(5,'PLASMA',7,8),(6,'PORTABLE ELECTRONICS',10,19),
(7,'MP3 PLAYERS',11,14),(8,'FLASH',12,13),
(9,'CD PLAYERS',15,16),(10,'2 WAY RADIOS',17,18);
*/