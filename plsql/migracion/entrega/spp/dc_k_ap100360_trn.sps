create or replace PACKAGE dc_k_ap100360_trn
AS
	/**
	|| Mantenimiento de la tabla a1004800
	||
	|| Procedimientos y funciones para el mantenimiento de la tabla a1004800
	*/
	--
	/* -------------------- VERSION = 1.00 -------------------- */
	--
	/*  -------------------- MODIFICACIONES --------------------
	|| 2019/11/04  - GCRUBEN - 1.00 - ()
	|| Creacion del Package - Procedimientos y funciones encargados de manejar el programa
	|| AP100360 (Procesos PROPHET)
	*/ --------------------------------------------------------
	--
	--{{ TG_GPUB
	/* -------------------------------------------
	|| ! ATENCION ! Codigo PL del usuario
	|| Definiciones Publicas: Tipos, Constantes, etc
	*/ -------------------------------------------
	--
	--}} TG_GPUB
	--
	--
	-- ------------------------------------------------------------
	--
	/**
	|| Inserta un registro en la tabla
	*/
	PROCEDURE p_inserta (p_reg a1004800%ROWTYPE);
	--
	--
	-- ------------------------------------------------------------
	--
	/**
	|| Lee el registro para consulta/actualizacion
	*/
	PROCEDURE p_query(
					p_idn_int_proc   a1004800.idn_int_proc  %TYPE,
					p_cod_proc       a1004800.cod_proc      %TYPE,
					p_fec_proc       a1004800.fec_hasta_proc%TYPE,
					p_txt_alias_proc     a1004800.txt_alias_proc    %TYPE);
	--
	--
	-- ------------------------------------------------------------
	--
	/**
	|| Devuelve la fila al programa de mantenimiento
	*/
	PROCEDURE p_devuelve(
			p_num_secu_k     IN OUT NUMBER,
			p_idn_int_proc   IN OUT a1004800.idn_int_proc  %TYPE,
			p_cod_proc       IN OUT a1004800.cod_proc      %TYPE,
			p_nom_proc       IN OUT g1010031.nom_valor     %TYPE,
			p_txt_alias_proc IN OUT a1004800.txt_alias_proc%TYPE,
			p_fec_desde_proc IN OUT a1004800.fec_desde_proc%TYPE,
			p_fec_hasta_proc IN OUT a1004800.fec_hasta_proc%TYPE,
			p_mca_enviado    IN OUT a1004800.mca_enviado   %TYPE,
			p_tip_situ_proc  IN OUT a1004800.tip_situ_proc %TYPE,
			p_nom_tip_situ_p IN OUT g1010031.nom_valor     %TYPE,
			p_cod_usr        IN OUT a1004800.cod_usr       %TYPE,
			p_fec_actu       IN OUT a1004800.fec_actu      %TYPE);
	--
	--
	-- ------------------------------------------------------------
	--
	/**
	|| Devuelve los campos pk para habilitar/deshabilitar
	*/
	FUNCTION f_devuelve_pk RETURN VARCHAR2;
	--
	--
	-- ------------------------------------------------------------
	--
	/**
	|| Comprueba si puede crear el registro
	*/
	PROCEDURE p_alta(p_cod_pgm VARCHAR2);
	--
	--
	-- ------------------------------------------------------------
	--
	/**
	|| Comprueba si puede modificar el registro
	*/
	PROCEDURE p_modifica(p_num_secu_k NUMBER  ,
							p_cod_pgm    VARCHAR2);
	--
		--
		-- ------------------------------------------------------------
	--
	-- ------------------------------------------------------------
	--
	/**
	|| Comprueba si puede borrar el registro y lo borra
	*/
	PROCEDURE p_borra(p_num_secu_k NUMBER  ,
						p_cod_pgm    VARCHAR2);
	--
	--
	-- ------------------------------------------------------------
	--
	/**
	|| Actualiza el registro
	*/
	PROCEDURE p_actualiza(
			p_num_secu_k     IN OUT NUMBER,
			p_idn_int_proc   IN OUT a1004800.idn_int_proc  %TYPE,
			p_cod_proc       IN OUT a1004800.cod_proc      %TYPE,
			p_nom_proc       IN OUT g1010031.nom_valor     %TYPE,
			p_txt_alias_proc IN OUT a1004800.txt_alias_proc%TYPE,
			p_fec_desde_proc IN OUT a1004800.fec_desde_proc%TYPE,
			p_fec_hasta_proc IN OUT a1004800.fec_hasta_proc%TYPE,
			p_mca_enviado    IN OUT a1004800.mca_enviado   %TYPE,
			p_tip_situ_proc  IN OUT a1004800.tip_situ_proc %TYPE,
			p_nom_tip_situ_p IN OUT g1010031.nom_valor     %TYPE,
			p_cod_usr        IN OUT a1004800.cod_usr       %TYPE,
			p_fec_actu       IN OUT a1004800.fec_actu      %TYPE);
	--
	--
	-- ------------------------------------------------------------
	--
	/**
	|| Graba la informacion de los nuevos registros
	*/
	PROCEDURE p_graba;
	--
	--
	-- ------------------------------------------------------------
	--
	/**
	|| Controla si hay cambios no grabados
	*/
	FUNCTION f_hay_cambios RETURN VARCHAR2;
	--
	-- ------------------------------------------------------------
	--
	/**
	|| Valida la columna : cod_proc
	*/
	PROCEDURE p_v_cod_proc
				(p_cod_proc     IN     a1004800.cod_proc  %TYPE,
				p_nom_proc      IN OUT g1010031.nom_valor %TYPE);
	--
	-- ------------------------------------------------------------
	--
	/**
	|| Valida la columna : txt_alias_proc
	*/
	PROCEDURE p_v_txt_alias_proc
				(p_txt_alias_proc     IN     a1004800.txt_alias_proc    %TYPE);
	--
	--
	-- ------------------------------------------------------------
	--
	/**
	|| Valida la columna : fec_desde_proc
	*/
	PROCEDURE p_v_fec_desde_proc
				(p_fec_desde_proc IN     a1004800.fec_desde_proc%TYPE);
	--
	--
	-- ------------------------------------------------------------
	--
	/**
	|| Valida la columna : fec_hasta_proc
	*/
	PROCEDURE p_v_fec_hasta_proc
				(p_fec_hasta_proc IN     a1004800.fec_hasta_proc%TYPE,
				p_fec_desde_proc IN     a1004800.fec_desde_proc%TYPE);
	--
	--
	-- ------------------------------------------------------------
	--
	/**
	|| Leer la columna y su look-up para:tip_situ_proc
	*/
	PROCEDURE p_look_up_tip_situ_proc
			(p_tip_situ_proc  IN     a1004800.tip_situ_proc %TYPE,
			p_nom_tip_situ_p IN OUT g1010031.nom_valor     %TYPE);
	--
	-- ------------------------------------------------------------
	--
	/**
	|| Valida la columna : tip_situ_proc
	*/
	PROCEDURE p_v_tip_situ_proc
				(p_tip_situ_proc  IN     a1004800.tip_situ_proc %TYPE,
			p_nom_tip_situ_p IN OUT g1010031.nom_valor     %TYPE);
	--
	--
	-- ------------------------------------------------------------
	--
	/**
	|| Valida la columna : mca_enviado
	*/
	PROCEDURE p_v_mca_enviado
				(p_mca_enviado        IN     a1004800.mca_enviado %TYPE);
	--
	--
	-- ------------------------------------------------------------
	--
	/**
	|| Valida la columna : cod_usr
	*/
	PROCEDURE p_v_cod_usr
				(p_cod_usr        IN     a1004800.cod_usr       %TYPE);
	--
	--
	-- ------------------------------------------------------------
	--
	/**
	|| Valida la columna : fec_actu
	*/
	PROCEDURE p_v_fec_actu
				(p_fec_actu       IN     a1004800.fec_actu      %TYPE);
	--
	--
	-- ------------------------------------------------------------
	--
	/**
	|| Genera el listado de la consulta
	*/
	PROCEDURE p_lista(p_nom_listado IN OUT VARCHAR2);
	--
	--
	-- ------------------------------------------------------------
	--
	/**
	|| Para inicializar el package
	*/
	PROCEDURE p_inicio;
	--
	--
	-- ------------------------------------------------------------
	--
	/**
	|| Para terminar el package
	*/
	PROCEDURE p_termina;
	--
	--
	-- ------------------------------------------------------------
	--
	/**
	|| p_inicio_procesamiento : Realiza la obtencion inicial
	*/
	PROCEDURE p_inicio_procesamiento(p_idn_int_proc         IN            a1004800.idn_int_proc  %TYPE,
										p_num_opcion_menu      IN            G1010131.num_opcion   %TYPE,
										p_mca_errores          IN OUT        VARCHAR2);
	--
	PROCEDURE p_cambia_estado_temp (p_num_opcion_menu      IN            G1010131.num_opcion    %TYPE);
	--
	--{{ TG_PPUB_E
	/* -------------------------------------------
	|| ! ATENCION ! Codigo PL del usuario
	|| Procedimientos Publicos (Especificacion)
	*/ -------------------------------------------
	--
	--}} TG_PPUB_E
	--
END dc_k_ap100360_trn;

--
CREATE OR REPLACE EDITIONABLE SYNONYM "TRON2000"."DC_K_AP100360" FOR "TRON2000"."DC_K_AP100360_TRN";