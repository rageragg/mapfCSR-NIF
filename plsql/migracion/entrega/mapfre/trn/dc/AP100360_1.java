package mapfre.trn.dc;

import java.awt.BorderLayout;
import java.awt.Dialog;
import java.awt.Dimension;
import java.awt.FlowLayout;
import java.awt.Insets;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Vector;

import javax.swing.BoxLayout;

import mapfre.com.c.GUI.TButton;
import mapfre.com.c.GUI.TPanel;
import mapfre.trn.Globales;
import mapfre.trn.Herramientas;

/**
 * CONSTRUCCION:      1
 * ULTIMA ACTUALIZACION: 2020/03/03
 * ---------------------------------------------------
 * 2020/03/03 - BLAZQUF - 2.0 - ()
 * Se juntan las pantallas PROPHET y FPSL en una sola pantalla.
 * La pantalla AP100361 desaparece dejando unicamente AP100360
 * ---------------------------------------------------
 * 2019/12/04 - GCRUBEN - 1.0 - ()
 * Version inicial - Programa encargado de la gestión de procesos PROPHET - FPSL
 * ----------------------------------------------------------
 */   

//Escriba su código entre los comentarios TG_IMP
//<<TG_IMP
//>>TG_IMP

// [JAVADOC] 

public class AP100360_1 extends mapfre.com.c.GUI.TDialogImputacion 
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 167165656346493492L;


	//Escriba su código entre los comentarios TG_CBC
	//<<TG_CBC
	//>>TG_CBC


		/** El siguiente código se genera automáticamente por Visual Cafe al <br>
		 * añadir componentes al entorno visual. A partir del mismo se crean <br>
		 * ejemplares e inicializan componentes. Para modificarlo , use solo  <br>
		 * sintaxis que concuerde con lo que Visual Cafe pueda generar, o el  <br>
		 * sistema podría verse incapaz de analizar el archivo java dentro del entorno visual <br>
		 */ 

	public AP100360_1(Vector pvParametros)
	{
		super((Dialog)pvParametros.lastElement());//Enlace con la ventana padre
		vParametros = pvParametros;
		//{{INIT_CONTROLS
		setDefaultCloseOperation(javax.swing.JFrame.DO_NOTHING_ON_CLOSE);
		setMetodoInicio(this,"preDlgImputacion");
		setModuloCodigo("trn,265");
		getContentPane().setLayout(new BorderLayout(0,0));
		setSize(794,209);
		setVisible(false);
		pnlBarrasHerramientas.setMetodoTeclas(this,"null");
		pnlBarrasHerramientas.setLayout(new FlowLayout(FlowLayout.LEFT,5,0));
		getContentPane().add(BorderLayout.NORTH, pnlBarrasHerramientas);
		brhGeneral.setBotonesDefecto("DatosBHGeneral");
		brhGeneral.setLayout(new FlowLayout(FlowLayout.LEFT,5,2));
		pnlBarrasHerramientas.add(brhGeneral);
		brhImputacion.setBotonesDefecto("DatosBHImputacion");
		brhImputacion.setLayout(new FlowLayout(FlowLayout.LEFT,5,2));
		pnlBarrasHerramientas.add(brhImputacion);
		scrPrincipal.setOpaque(true);
		getContentPane().add(BorderLayout.CENTER, scrPrincipal);
		pnlPrincipal0.setLayout(new BorderLayout(0,0));
		scrPrincipal.getViewport().add(pnlPrincipal0);
		pnlPrincipal0.setBounds(0,0,23,40);
		pnlQuery.setBorder(ttlSinTitulo);
		pnlQuery.setOpaque(false);
		pnlQuery.setLayout(new FlowLayout(FlowLayout.CENTER,5,5));
		pnlPrincipal0.add(BorderLayout.CENTER,pnlQuery);
		pnlDatos0.setBotonDefecto(btnAceptar);
		pnlDatos0.setMetodoPrePanel(this,"prePnlDatos");
		pnlDatos0.setMetodoTeclas(this,"null");
		pnlDatos0.setOpaque(false);
		pnlDatos0.setLayout(new BoxLayout(pnlDatos0,BoxLayout.Y_AXIS));
		pnlQuery.add(pnlDatos0);
		pnlImpInfo0.setOpaque(false);
		pnlImpInfo0.setLayout(new FlowLayout(FlowLayout.LEFT,5,1));
		pnlDatos0.add(pnlImpInfo0);
		pnlImpInfo1.setOpaque(false);
		pnlImpInfo1.setLayout(new FlowLayout(FlowLayout.LEFT,5,1));
		pnlDatos0.add(pnlImpInfo1);

		txtImpIdnIntProc.setNombreCampo("IdnIntProc");
		txtImpIdnIntProc.setTipoDato("NUMERICO");
		txtImpIdnIntProc.setLongitud("15,22");
		txtImpIdnIntProc.setPanelGrupo(pnlQuery);
		txtImpIdnIntProc.setToolTip("trn,32");
		txtImpIdnIntProc.setTipoAnchura("TABLA");
		txtImpIdnIntProc.setVisible(false);
		txtImpIdnIntProc.setValidaNulo(false);
		sprImpCodIntProc.setPixelsSeparacion(0);
		pnlImpInfo1.add(sprImpCodIntProc);
		
		lblImpCodProc.setAnchura(130);
		lblImpCodProc.setModuloCodigo("trn,32");
		pnlImpInfo1.add(lblImpCodProc);
		txtImpCodProc.setNombreCampo("CodIntProc");
		txtImpCodProc.setTipoDato("TEXTO");
		txtImpCodProc.setLongitud("2,2");
		txtImpCodProc.setFuncionValidacion("DC_K_AP100360.p_v_cod_proc(2)");
		txtImpCodProc.setMetodoPreValidacion(this,"preValtxtImpCodProc");
		txtImpCodProc.setMetodoPostValidacion(this,"posValtxtImpCodProc");
		txtImpCodProc.setPanelGrupo(pnlQuery);
		txtImpCodProc.setListaOpciones("NIIF-17,999");
		txtImpCodProc.setToolTip("trn,32");
		txtImpCodProc.setTipoAnchura("TABLA");
		txtImpCodProc.setEnabled(true);
		txtImpCodProc.setValidaNulo(true);
		pnlImpInfo1.add(txtImpCodProc);
		txtImpNomProc.setNombreCampo("NomProc");
		txtImpNomProc.setTipoDato("TEXTO");
		txtImpNomProc.setLongitud("40,40");
		txtImpNomProc.setGranEdicion(true);
		txtImpNomProc.setPanelGrupo(pnlQuery);
		txtImpNomProc.setToolTip("trn,32");
		txtImpNomProc.setTipoAnchura("TABLA");
		txtImpNomProc.setEnabled(false);
		txtImpNomProc.setValidaNulo(false);
		pnlImpInfo1.add(txtImpNomProc);

		pnlImpInfo2.setOpaque(false);
		pnlImpInfo2.setLayout(new FlowLayout(FlowLayout.LEFT,5,1));
		pnlDatos0.add(pnlImpInfo2);

		sprImpAliasProc.setPixelsSeparacion(0);
		pnlImpInfo2.add(sprImpAliasProc);
		lblImpAliasProc.setAnchura(-1);
		lblImpAliasProc.setModuloCodigo("trn,368");
		pnlImpInfo2.add(lblImpAliasProc);
		txtImpAliasProc.setNombreCampo("AliasProc");
		txtImpAliasProc.setTipoDato("TEXTO");
		txtImpAliasProc.setLongitud("20,30");
		txtImpAliasProc.setObligatorio(true);
		txtImpAliasProc.setFuncionValidacion("DC_K_AP100360.p_v_txt_alias_proc(1)");
		txtImpAliasProc.setMetodoPreValidacion(this,"preValTxtImpAliasProc");
		txtImpAliasProc.setPanelGrupo(pnlQuery);
		txtImpAliasProc.setToolTip("trn,368");
		txtImpAliasProc.setTipoAnchura("TABLA");
		txtImpAliasProc.setValidaNulo(false);
		pnlImpInfo2.add(txtImpAliasProc);
		/*		 */
		sprImpFecDesdeProc.setPixelsSeparacion(0);
		pnlImpInfo2.add(sprImpFecDesdeProc);
		lblImpFecDesdeProc.setAnchura(130);
		lblImpFecDesdeProc.setModuloCodigo("trn,735");
		pnlImpInfo2.add(lblImpFecDesdeProc);
		txtImpFecDesdeProc.setNombreCampo("FecDesdeProc");
		txtImpFecDesdeProc.setMascaraFecha("dd-MM-yyyy");
		txtImpFecDesdeProc.setTipoDato("FECHA");
		txtImpFecDesdeProc.setLongitud("10,8");
		txtImpFecDesdeProc.setObligatorio(true);
		txtImpFecDesdeProc.setMascaraFecha("dd-MM-yyyy");
		txtImpFecDesdeProc.setFuncionValidacion("DC_K_AP100360.p_v_fec_desde_proc(1)");
		txtImpFecDesdeProc.setMetodoPreValidacion(this,"preValTxtImpFecDesdeProc");
		txtImpFecDesdeProc.setPanelGrupo(pnlQuery);
		txtImpFecDesdeProc.setToolTip("trn,735");
		txtImpFecDesdeProc.setTipoAnchura("TABLA");
		txtImpFecDesdeProc.setValidaNulo(false);
		pnlImpInfo2.add(txtImpFecDesdeProc);
		sprImpFecHastaProc.setPixelsSeparacion(0);
		pnlImpInfo2.add(sprImpFecHastaProc);
		lblImpFecHastaProc.setAnchura(-1);
		lblImpFecHastaProc.setModuloCodigo("trn,736");
		pnlImpInfo2.add(lblImpFecHastaProc);
		txtImpFecHastaProc.setNombreCampo("FecHastaProc");
		txtImpFecHastaProc.setMascaraFecha("dd-MM-yyyy");
		txtImpFecHastaProc.setTipoDato("FECHA");
		txtImpFecHastaProc.setLongitud("10,8");
		txtImpFecHastaProc.setObligatorio(true);
		txtImpFecHastaProc.setMascaraFecha("dd-MM-yyyy");
		txtImpFecHastaProc.setFuncionValidacion("DC_K_AP100360.p_v_fec_hasta_proc(2)");
		txtImpFecHastaProc.setMetodoPreValidacion(this,"preValTxtImpFecHastaProc");
		txtImpFecHastaProc.setMetodoPostValidacion(this,"posValTxtImpFecHastaProc");
		txtImpFecHastaProc.setPanelGrupo(pnlQuery);
		txtImpFecHastaProc.setToolTip("trn,736");
		txtImpFecHastaProc.setTipoAnchura("TABLA");
		txtImpFecHastaProc.setValidaNulo(false);
		pnlImpInfo2.add(txtImpFecHastaProc);

		pnlImpInfo3.setOpaque(false);
		pnlImpInfo3.setLayout(new FlowLayout(FlowLayout.LEFT,5,1));
		pnlDatos0.add(pnlImpInfo3);
		sprImpTipSituProc.setPixelsSeparacion(0);
		pnlImpInfo3.add(sprImpTipSituProc);
		lblImpTipSituProc.setAnchura(130);
		lblImpTipSituProc.setModuloCodigo("trn,1825");
		pnlImpInfo3.add(lblImpTipSituProc);
		txtImpTipSituProc.setNombreCampo("TipSituProc");
		txtImpTipSituProc.setTipoDato("TEXTO");
		txtImpTipSituProc.setLongitud("3,3");
		txtImpTipSituProc.setObligatorio(true);
		txtImpTipSituProc.setFuncionValidacion("DC_K_AP100360.p_v_tip_situ_proc(2)");
		txtImpTipSituProc.setMetodoPreValidacion(this,"preValTxtImpTipSituProc");
		txtImpTipSituProc.setPanelGrupo(pnlQuery);
		txtImpTipSituProc.setToolTip("trn,1825");
		txtImpTipSituProc.setTipoAnchura("TABLA");
		txtImpTipSituProc.setListaOpciones("TIP_SITU_PROC3,999");	
		txtImpTipSituProc.setEnabled(false);
		txtImpTipSituProc.setValidaNulo(false);
		pnlImpInfo3.add(txtImpTipSituProc);
		txtImpNomTipSituProc.setNombreCampo("NomTipSituProc");
		txtImpNomTipSituProc.setTipoDato("TEXTO");
		txtImpNomTipSituProc.setLongitud("40,40");
		txtImpNomTipSituProc.setGranEdicion(true);
		txtImpNomTipSituProc.setPanelGrupo(pnlQuery);
		txtImpNomTipSituProc.setToolTip("trn,1825");
		txtImpNomTipSituProc.setTipoAnchura("TABLA");
		txtImpNomTipSituProc.setEnabled(false);
		txtImpNomTipSituProc.setValidaNulo(false);
		pnlImpInfo3.add(txtImpNomTipSituProc);
		chkImpMcaEnviado.setValorPositivo("S");
		chkImpMcaEnviado.setValorNegativo("N");
		chkImpMcaEnviado.setModuloCodigo("trn,1826");
		chkImpMcaEnviado.setPanelGrupo(pnlQuery);
		pnlImpInfo3.add(chkImpMcaEnviado);
		chkImpMcaEnviado.setEnabled(false);
		pnlBotones.setMetodoTeclas(this,"null");
		pnlBotones.setBorder(ttlSinTitulo);
		pnlBotones.setOpaque(false);
		pnlBotones.setLayout(new FlowLayout(FlowLayout.RIGHT,5,5));
		pnlPrincipal0.add(BorderLayout.SOUTH, pnlBotones);
		btnNuevaEntrada.setMetodoAccion(this,"accionBtnNuevaEntrada");
		btnNuevaEntrada.setModuloCodigo("trn,271");
		btnNuevaEntrada.setActionCommand("Nueva Entrada");
		pnlBotones.add(btnNuevaEntrada);
		btnAceptar.setMetodoAccion(this,"accionBtnAceptar");
		pnlBotones.add(btnAceptar);
		getContentPane().add(BorderLayout.SOUTH, brsEstado);
		ttlSinTitulo.setTitleFont(new java.awt.Font("Dialog",java.awt.Font.BOLD,12));
		//$$ ttlSinTitulo.move(0,546);
		//}}

		this.setAutoCommit(true);
		//Escriba su código entre los comentarios TG_CNS
		//<<TG_CNS
/*
		txtImpFecDesdeProc.setMetodoPreCampo(this,"txtImpFecDesdeProcPreCampo");
		txtImpFecDesdeProc.setMetodoPostCampo(this,"txtImpFecDesdeProcPosCampo");
*/
		txtImpFecDesdeProc.setMetodoPreCampo(this,"txtImpFecHastaProcPreCampo");
		txtImpFecDesdeProc.setMetodoPostCampo(this,"txtImpFecHastaProcPosCampo");
		txtImpTipSituProc.setMetodoPreCampo("txtImpTipSituProcPreCampo");
				
		//>>TG_CNS

		inicio();
	} // Fin de la constructora

	//{{DECLARE_CONTROLS
	mapfre.com.c.GUI.TPanel pnlBarrasHerramientas = new mapfre.com.c.GUI.TPanel();
	mapfre.com.c.GUI.TBarraHerramientas brhGeneral = new mapfre.com.c.GUI.TBarraHerramientas();
	mapfre.com.c.GUI.TBarraHerramientas brhImputacion = new mapfre.com.c.GUI.TBarraHerramientas();
	mapfre.com.c.GUI.TScrollPanel scrPrincipal = new mapfre.com.c.GUI.TScrollPanel();
	mapfre.com.c.GUI.ImageTPanel pnlPrincipal0 = new mapfre.com.c.GUI.ImageTPanel();
	mapfre.com.c.GUI.TPanel pnlQuery = new mapfre.com.c.GUI.TPanel();
	mapfre.com.c.GUI.TPanel pnlDatos0 = new mapfre.com.c.GUI.TPanel();
	mapfre.com.c.GUI.TPanel pnlBotones = new mapfre.com.c.GUI.TPanel();
	mapfre.com.c.GUI.TButton btnNuevaEntrada = new mapfre.com.c.GUI.TButton();
	mapfre.com.c.GUI.TButtonAceptar btnAceptar = new mapfre.com.c.GUI.TButtonAceptar();
	mapfre.com.c.GUI.TBarraEstado brsEstado = new mapfre.com.c.GUI.TBarraEstado();
	mapfre.com.c.GUI.TTitledBorder ttlSinTitulo = new mapfre.com.c.GUI.TTitledBorder();	
	mapfre.com.c.GUI.TPanel pnlImpInfo0 = new mapfre.com.c.GUI.TPanel ();
	mapfre.com.c.GUI.TPanel pnlImpInfo1 = new mapfre.com.c.GUI.TPanel ();
	mapfre.com.c.GUI.TSeparador sprImpCodIntProc = new mapfre.com.c.GUI.TSeparador();
	mapfre.com.c.GUI.TLabel lblImpCodProc = new mapfre.com.c.GUI.TLabel();
	mapfre.com.c.GUI.TTextField txtImpIdnIntProc = new mapfre.com.c.GUI.TTextField();	
	mapfre.com.c.GUI.TTextField txtImpCodProc = new mapfre.com.c.GUI.TTextField();
	mapfre.com.c.GUI.TTextField txtImpNomProc = new mapfre.com.c.GUI.TTextField();
	mapfre.com.c.GUI.TSeparador sprImpAliasProc = new mapfre.com.c.GUI.TSeparador();
	mapfre.com.c.GUI.TLabel lblImpAliasProc = new mapfre.com.c.GUI.TLabel();
	mapfre.com.c.GUI.TTextField txtImpAliasProc = new mapfre.com.c.GUI.TTextField();
	mapfre.com.c.GUI.TPanel pnlImpInfo2 = new mapfre.com.c.GUI.TPanel ();
	mapfre.com.c.GUI.TSeparador sprImpFecDesdeProc = new mapfre.com.c.GUI.TSeparador();
	mapfre.com.c.GUI.TLabel lblImpFecDesdeProc = new mapfre.com.c.GUI.TLabel();
	mapfre.com.c.GUI.TTextField txtImpFecDesdeProc = new mapfre.com.c.GUI.TTextField();
	mapfre.com.c.GUI.TSeparador sprImpFecHastaProc = new mapfre.com.c.GUI.TSeparador();
	mapfre.com.c.GUI.TLabel lblImpFecHastaProc = new mapfre.com.c.GUI.TLabel();
	mapfre.com.c.GUI.TTextField txtImpFecHastaProc = new mapfre.com.c.GUI.TTextField();
	mapfre.com.c.GUI.TPanel pnlImpInfo3 = new mapfre.com.c.GUI.TPanel ();
	mapfre.com.c.GUI.TSeparador sprImpTipSituProc = new mapfre.com.c.GUI.TSeparador();
	mapfre.com.c.GUI.TLabel lblImpTipSituProc = new mapfre.com.c.GUI.TLabel();
	mapfre.com.c.GUI.TTextField txtImpTipSituProc = new mapfre.com.c.GUI.TTextField();
	mapfre.com.c.GUI.TTextField txtImpNomTipSituProc = new mapfre.com.c.GUI.TTextField();
	mapfre.com.c.GUI.TCheckBox chkImpMcaEnviado = new mapfre.com.c.GUI.TCheckBox();
	//}}

	Vector vParametros;
	private Object [] camposRelleno = new Object [] {	 
	txtImpIdnIntProc
	,txtImpCodProc
	,txtImpNomProc
	,txtImpAliasProc
	,txtImpFecDesdeProc
	,txtImpFecHastaProc
	,chkImpMcaEnviado
	,txtImpTipSituProc		
	,txtImpNomTipSituProc		
	       };
	
	private int[] posicionTabla = new int [] {
 	AP100360.IDNINTPROC
	,AP100360.CODPROC
	,AP100360.NOMCODPROC
	,AP100360.ALIASPROC
	,AP100360.FECDESDEPROC
	,AP100360.FECHASTAPROC
	,AP100360.MCAENVIADO
	,AP100360.TIPSITUPROC	
	,AP100360.NOMTIPSITUPROC	
	      };


	/** 
	 * Metodo de Inicio del Dialogo
	 */ 
	public Boolean preDlgImputacion()
	{
		//Asignamos la global de fec actu
		SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
		Globales.setVariableGeneral("fec_actu", (String) sdf.format(new Date()) );
				
		//Guardamos el valor de IdnIntProc
		
		if (!super.preDlgImputacion().booleanValue()) //No eliminar esta línea
		{
			return Boolean.FALSE;
		}
		if (!isAlta())
		{
			txtImpCodProc.setObligatorio(false);
			txtImpCodProc.setEnabled(false);
		}
		return Boolean.TRUE;
	}

	//====METODOS PRE VALIDACIÓN=====
	/**
	 * Preparacion de la funcion de Validación de txtImpCodProc
	 */
	public Boolean preValtxtImpCodProc()
	{
		txtImpCodProc.addParametro(txtImpCodProc, "IN", 0, 2);
		txtImpCodProc.addParametro(txtImpNomProc, "IN OUT", 1, 2);
		return Boolean.TRUE;
	}//Fin de preValtxtImpCodProc
	/**
	 * Preparacion de la funcion de Validación de txtImpAliasProc
	 */
	public Boolean preValTxtImpAliasProc()
	{
		txtImpAliasProc.addParametro(txtImpAliasProc, "IN", 0, 1);
		return Boolean.TRUE;
	}//Fin de preValTxtImpAliasProc

	/**
	 * Preparacion de la funcion de Validación de txtImpFecDesdeProc
	 */
	public Boolean preValTxtImpFecDesdeProc()
	{
		txtImpFecDesdeProc.addParametro(txtImpFecDesdeProc, "IN", 0, 1);
		return Boolean.TRUE;
	}//Fin de preValTxtImpFecDesdeProc
	 
	/**
	 * Preparacion de la funcion de Validación de txtImpFecHastaProc
	 */
	public Boolean preValTxtImpFecHastaProc()
	{
		txtImpFecHastaProc.addParametro(txtImpFecHastaProc, "IN", 0, 2);
		txtImpFecHastaProc.addParametro(txtImpFecDesdeProc, "IN", 1, 2);
		return Boolean.TRUE;
	}//Fin de preValTxtImpFecHastaProc

	/**
	 * Preparacion de la funcion de Validación de txtImpTipSituProc
	 */
	public Boolean preValTxtImpTipSituProc()
	{
		txtImpTipSituProc.addParametro(txtImpTipSituProc, "IN", 0, 2);
		txtImpTipSituProc.addParametro(txtImpNomTipSituProc, "IN OUT", 1, 2);
		return Boolean.TRUE;
	}//Fin de preValTxtImpTipSituProc

	//====METODOS POS VALIDACIÓN=====
	/**
	 * Validacion de txtImpCodProc
	 */
	public Boolean posValtxtImpCodProc()
	{
       if (this.txtImpCodProc.getText().equals("P"))
       {
    	   txtImpFecDesdeProc.setText("");
    	   txtImpFecDesdeProc.setEnabled(false);
       }
       else
       {
    	   txtImpFecDesdeProc.setText("");
    	   txtImpFecDesdeProc.setEnabled(true);
       }
       return Boolean.TRUE;

	}//Fin de posValtxtImpCodProc
	

	/**
	 * Validacion de TxtImpFecHastaProc
	 */
	public Boolean posValTxtImpFecHastaProc()
	{
		
		if (this.txtImpCodProc.getText().equals("P") && 
           this.txtImpFecDesdeProc.getText().equals("")) 
       {
    	   txtImpFecDesdeProc.setText(txtImpFecHastaProc.getText());
       }

		if (isAlta())
		{
			txtImpTipSituProc.setText("1");
			this.preValTxtImpTipSituProc();
			txtImpTipSituProc.lanzaValidacionOracle();
		}
       return Boolean.TRUE;

	}//Fin de posValTxtImpFecHastaProc

	
	
	//====METODOS DEL MANTENIMIENTO DE TABLA=====
	protected Object[] getArgumentosCrearRegistro()
	{
		//argumentos del mantenimiento
		return new Object[] { 
		""
		,txtImpIdnIntProc
		,txtImpCodProc
		,txtImpNomProc
		,txtImpAliasProc
		,txtImpFecDesdeProc
		,txtImpFecHastaProc
		,chkImpMcaEnviado
		,txtImpTipSituProc				
		,txtImpNomTipSituProc		
		,Globales.getVariableGeneral("cod_usr")
		,Globales.getVariableGeneral("fec_actu")
		};//fin del return
	}//fin de CrearRegistro 

	protected Object[] getArgumentosActualizarRegistro()
	{
		//argumentos del mantenimiento
		return new Object[] {
		getCampoTabla(AP100360.NUMSECUK)
		,txtImpIdnIntProc
		,txtImpCodProc
		,txtImpNomProc
		,txtImpAliasProc
		,txtImpFecDesdeProc
		,txtImpFecHastaProc
		,chkImpMcaEnviado
		,txtImpTipSituProc
		,txtImpNomTipSituProc
		,Globales.getVariableGeneral("cod_usr")
		,Globales.getVariableGeneral("fec_actu")
		};//fin del return
	}//fin de ActualizarRegistro 

	protected Object[] getRellenoAlta()
	{
		return new Object[] {
			new Object[] {
				 txtImpIdnIntProc
				,txtImpFecHastaProc
				,txtImpAliasProc
			},
			new Object[] {
				((AP100360)getDlgPadre()).txtQueryIdnIntProc
				,((AP100360)getDlgPadre()).txtQueryFecProceso
				,((AP100360)getDlgPadre()).txtQueryAliasProc
			}
		};
	}

//========================================================================================
	//METODOS QUE NECESITA TDialogImputacion PARA OPERAR CORRECTAMENTE
	//los siguientes métodos son generados automáticamente y no deben
	//ser modificados por el programador

	//Recupera el botón de Nueva Entrada
	protected TButton       getBtnNuevaEntrada() {return btnNuevaEntrada;}

	//Recupera el botón de Aceptar
	protected TButton       getBtnAceptar() {return btnAceptar;}

	//Recupera el panel que abarca a los campos de imputación
	protected TPanel        getPnlDatos() {return pnlDatos0;}

	//Recupera la lista de parámetros pasada por el constructor
	protected Vector        getParametros() {return vParametros;}      

	//Recupera la información necesaria para rellenar automáticamente los campos
	//cuando la pantalla es de Modificación
	protected Object[]      getRelleno() {return new Object [] {camposRelleno, posicionTabla};}
	

	/**
	 * Codigo Generado por VisualCafe <br>
	 * Record the size of the window prior to calling parents addNotify.<br>
	 * Adjust size of frame according to the insets and menu bar 
	 */
	public void addNotify()
	{
		// Record the size of the window prior to calling parents addNotify.
		Dimension size = getSize();
		super.addNotify();
		if (frameSizeAdjusted)
			return;
		frameSizeAdjusted = true;
		// Adjust size of frame according to the insets and menu bar
		Insets insets = getInsets();
		javax.swing.JMenuBar menuBar = getRootPane().getJMenuBar();
		int menuBarHeight = 0;
		if (menuBar != null)
			menuBarHeight = menuBar.getPreferredSize().height;
		setSize(insets.left + insets.right + size.width, insets.top + insets.bottom + size.height + menuBarHeight);
	}

	// Used by addNotify
	boolean frameSizeAdjusted = false;


	//Escriba su código entre los comentarios TG_CRP
	//<<TG_CRP
/*	public Boolean txtImpFecDesdeProcPreCampo()
	{
		if (txtImpFecDesdeProc.getText().equals(""))
		{
			txtImpFecDesdeProc.setText(Herramientas.getFechaActual("ddMMyyyy"));
		}
		return Boolean.TRUE;
	}
*/
/*
	public Boolean txtImpFecDesdeProcPosCampo()
	{
		if (!txtImpFecDesdeProc.getText().equals("") && txtImpFecHastaProc.getText().equals(""))
		{
			txtImpFecHastaProc.setText(txtImpFecDesdeProc.getText());
		}
		if (isAlta())
		{
			txtImpTipSituProc.setText("1");
			this.preValTxtImpTipSituProc();
			txtImpTipSituProc.lanzaValidacionOracle();
		}
		return Boolean.TRUE;
	}
*/
	public Boolean txtImpFecHastaProcPreCampo()
	{
		if (txtImpFecHastaProc.getText().equals(""))
		{
			txtImpFecHastaProc.setText(Herramientas.getFechaActual("ddMMyyyy"));
		}
		return Boolean.TRUE;
	}

	public Boolean txtImpFecHastaProcPosCampo() 
	{
		if (txtImpFecHastaProc.getText().equals(""))
		{
			txtImpFecHastaProc.setText(Herramientas.getFechaActual("ddMMyyyy"));
		}
		if (isAlta())
		{
			txtImpTipSituProc.setText("1");
			this.preValTxtImpTipSituProc();
			txtImpTipSituProc.lanzaValidacionOracle();
		}
		return Boolean.TRUE;
	}
	
	public Boolean txtImpTipSituProcPreCampo()
	{
	
		if (txtImpTipSituProc.getText().equals(""))
		{				
			txtImpTipSituProc.setEnabled(true);
			txtImpTipSituProc.setText("1");
		}
		return Boolean.TRUE;
	}
	
	
	//>>TG_CRP
} //Fin de la clase
