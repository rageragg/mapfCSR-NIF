package mapfre.trn.dc;

import java.awt.BorderLayout;
import java.awt.Dialog;
import java.awt.Dimension;
import java.awt.FlowLayout;
import java.awt.Frame;
import java.awt.GridBagLayout;
import java.awt.Insets;

import javax.swing.BoxLayout;
import javax.swing.UIManager;

import mapfre.com.c.GUI.TButton;
import mapfre.com.c.GUI.TPanel;
import mapfre.com.c.GUI.TTextField;
import mapfre.trn.ControlTeclas;
import mapfre.trn.Globales;
import mapfre.trn.Herramientas;
import mapfre.com.c.GUI.TBarraEspera;

/**
 * CONSTRUCCION:      2
 * ULTIMA ACTUALIZACION: 2020/03/03
 * ---------------------------------------------------
 * 2020/03/03 - BLAZQUF - 2.0 - ()
 * Se juntan las pantallas PROPHET y FPSL en una sola pantalla.
 * La pantalla AP100361 desaparece dejando unicamente AP100360
 * ---------------------------------------------------
 * 2019/12/04 - GCRUBEN - 1.0 - ()
 * Version inicial - Programa encargado de la gestion de procesos PROPHET - FPSL
 * ----------------------------------------------------------
 */   

//Escriba su codigo entre los comentarios TG_IMP
//<<TG_IMP
//>>TG_IMP

// [JAVADOC] 

public class AP100360 extends mapfre.com.c.GUI.TDialogQuery 
{
	TBarraEspera espera = null;
	/**
	 * 
	 */
	private static final long serialVersionUID = -4207608326361071921L;


	//Escriba su codigo entre los comentarios TG_CBC
	//<<TG_CBC
	//>>TG_CBC

	public AP100360()
	{
		super();
		init();
	} // Fin de la constructora

	public AP100360(Frame f)
	{
		super(f);
		init();
	}

	public AP100360(Dialog d)
	{
		super(d);
		init();
	}

		/** El siguiente codigo se genera automaticamente por Visual Cafe al <br>
		 * añadir componentes al entorno visual. A partir del mismo se crean <br>
		 * ejemplares e inicializan componentes. Para modificarlo , use solo  <br>
		 * sintaxis que concuerde con lo que Visual Cafe pueda generar, o el  <br>
		 * sistema podra verse incapaz de analizar el archivo java dentro del entorno visual <br>
		 */ 
	public void init()
	{
		//{{INIT_CONTROLS
		setMetodoInicio(this,"");
		setAutoCommit(false);
		setDatosPrograma("AP100360, 1.0, Genoma");
		getContentPane().setLayout(new BorderLayout(0,0));
		setSize(794,545);
		setVisible(false);
		pnlBarrasHerramientas.setMetodoTeclas(this,"null");
		pnlBarrasHerramientas.setLayout(new FlowLayout(FlowLayout.LEFT,5,2));
		getContentPane().add(BorderLayout.NORTH, pnlBarrasHerramientas);
		brhGeneral.setBotonesDefecto("DatosBHGeneral");
		brhGeneral.setLayout(new FlowLayout(FlowLayout.LEFT,5,5));
		pnlBarrasHerramientas.add(brhGeneral);
		brhGeneral.setBackground(java.awt.Color.lightGray);
		brhMantenimientoEdicion.setBotonesDefecto("DatosBHMantenimientoEdicion");
		brhMantenimientoEdicion.setLayout(new FlowLayout(FlowLayout.LEFT,5,5));
		pnlBarrasHerramientas.add(brhMantenimientoEdicion);
		pnlGeneral.setMetodoTeclas(this,"null");
		pnlGeneral.setLayout(new BorderLayout(0,0));
		getContentPane().add(BorderLayout.CENTER, pnlGeneral);
		scrGeneral.setOpaque(true);
		pnlGeneral.add(BorderLayout.CENTER, scrGeneral);
		pnlGeneral1.setLayout(new BorderLayout(0,0));
		scrGeneral.getViewport().add(pnlGeneral1);
		pnlGeneral1.setBounds(0,0,791,500);
		pnlQuery.setMetodoPrePanel(this,"prePnlQuery");
		pnlQuery.setMetodoTeclas(this,"teclasFuncionPnlQuery");
		pnlQuery.setBorder(ttlSinTitulo);
		pnlQuery.setOpaque(false);
		pnlQuery.setLayout(new FlowLayout(FlowLayout.CENTER,5,5));
		pnlGeneral1.add(BorderLayout.NORTH, pnlQuery);
		pnlQuery0.setMetodoTeclas(this,"null");
		pnlQuery0.setAlignmentX(0.498361F);
		pnlQuery0.setOpaque(false);
		pnlQuery0.setLayout(new BoxLayout(pnlQuery0,BoxLayout.Y_AXIS));
		pnlQuery.add(pnlQuery0);
		pnlQueryInfo0.setOpaque(false);
		pnlQueryInfo0.setLayout(new FlowLayout(FlowLayout.LEFT,5,1));
		pnlQuery0.add(pnlQueryInfo0);

		sprQueryCodProc.setPixelsSeparacion(0);
		pnlQueryInfo0.add(sprQueryCodProc);
		lblQueryCodProc.setAnchura(-1);
		lblQueryCodProc.setModuloCodigo("trn,32");
		pnlQueryInfo0.add(lblQueryCodProc);
		txtQueryCodProc.setNombreCampo("CodProc");
		txtQueryCodProc.setTipoDato("TEXTO");
		txtQueryCodProc.setLongitud("2,2");
		txtQueryCodProc.setCampoAsociado(txtQueryNomCodProc);
		txtQueryCodProc.setListaOpciones("NIIF-17,999");
		txtQueryCodProc.setPanelGrupo(pnlQuery);
		txtQueryCodProc.setToolTip("trn,32");
		txtQueryCodProc.setTipoAnchura("TABLA");
		txtQueryCodProc.setValidaNulo(false);
		pnlQueryInfo0.add(txtQueryCodProc);
		txtQueryNomCodProc.setTipoDato("TEXTO");
		txtQueryNomCodProc.setLongitud("12,10");
		txtQueryNomCodProc.setPanelGrupo(pnlQuery);
		txtQueryNomCodProc.setToolTip(" ");
		txtQueryNomCodProc.setTipoAnchura("TABLA");
		txtQueryNomCodProc.setValidaNulo(false);
		txtQueryNomCodProc.setEnabled(false);
		pnlQueryInfo0.add(txtQueryNomCodProc);
		
		sprQueryIdnIntProc.setPixelsSeparacion(0);
		pnlQueryInfo0.add(sprQueryIdnIntProc);
		lblQueryIdnIntProc.setAnchura(-1);
		lblQueryIdnIntProc.setModuloCodigo("trn,157");
		pnlQueryInfo0.add(lblQueryIdnIntProc);
		txtQueryIdnIntProc.setNombreCampo("CodIntProc");
		txtQueryIdnIntProc.setTipoDato("TEXTO");
		txtQueryIdnIntProc.setLongitud("15,22");
		txtQueryIdnIntProc.setPanelGrupo(pnlQuery);
		txtQueryIdnIntProc.setToolTip("trn,157");
		txtQueryIdnIntProc.setTipoAnchura("TABLA");
		txtQueryIdnIntProc.setValidaNulo(false);
		pnlQueryInfo0.add(txtQueryIdnIntProc);
		
		pnlQueryInfo1.setOpaque(false);
		pnlQueryInfo1.setLayout(new FlowLayout(FlowLayout.LEFT,5,1));
		pnlQuery0.add(pnlQueryInfo1);

		sprQueryAliasProc.setPixelsSeparacion(0);
		pnlQueryInfo1.add(sprQueryAliasProc);
		lblQueryAliasProc.setAnchura(-1);
		lblQueryAliasProc.setModuloCodigo("trn,368");
		pnlQueryInfo1.add(lblQueryAliasProc);
		txtQueryAliasProc.setNombreCampo("AliasProc");
		txtQueryAliasProc.setTipoDato("TEXTO");
		txtQueryAliasProc.setLongitud("20,30");
		txtQueryAliasProc.setPanelGrupo(pnlQuery);
		txtQueryAliasProc.setToolTip("trn,368");
		txtQueryAliasProc.setTipoAnchura("TABLA");
		txtQueryAliasProc.setValidaNulo(false);
		pnlQueryInfo1.add(txtQueryAliasProc);
		
		lblQueryFecProceso.setAnchura(-1);
		lblQueryFecProceso.setModuloCodigo("trn,736");
		pnlQueryInfo1.add(lblQueryFecProceso);
		txtQueryFecProceso.setNombreCampo("FechaHastaProc");
		txtQueryFecProceso.setTipoDato("FECHA");
		txtQueryFecProceso.setLongitud("10,8");
		txtQueryFecProceso.setPanelGrupo(pnlQuery);
		txtQueryFecProceso.setToolTip("trn,736");
		txtQueryFecProceso.setTipoAnchura("TABLA");
		txtQueryFecProceso.setMascaraFecha("dd-MM-yyyy");
		txtQueryFecProceso.setValidaNulo(false);
		pnlQueryInfo1.add(txtQueryFecProceso);
		sprConsultar.setPixelsSeparacion(0);
		pnlQueryInfo1.add(sprConsultar);
		btnConsultar.setMetodoAccion(this,"accionBtnConsultar");
		btnConsultar.setModuloCodigo("trn,22");
		btnConsultar.setActionCommand("Consultar");
		pnlQueryInfo1.add(btnConsultar);
		pnlDatos.setMetodoPrePanel(this,"prePnlDatos");
		pnlDatos.setMetodoTeclas(this,"teclasFuncionPnlDatos");
		pnlDatos.setOpaque(false);
		pnlDatos.setLayout(new BorderLayout(0,0));
		pnlGeneral1.add(BorderLayout.CENTER, pnlDatos);
		pnlDatos1.setOpaque(false);
		pnlDatos1.setLayout(new BorderLayout(0,0));
		pnlDatos.add(BorderLayout.CENTER, pnlDatos1);
		pnlTabla.setMetodoTeclas(this,"null");
		pnlTabla.setOpaque(false);
		pnlTabla.setLayout(new GridBagLayout());
		pnlDatos1.add(BorderLayout.CENTER, pnlTabla);
		tblTabla.setMetodoCambio(this,"cambioRegTblTabla");
		tblTabla.setMetodoBorrar(this,"preBorradoRegTblTabla");
		tblTabla.setMetodoTeclas(this,"teclasFunciontblTabla");
		tblTabla.setMetodoPreAlta(this,"preAltaRegTblTabla");
		tblTabla.setMetodoPreConsulta(this,"preConsultaTblTabla");
		tblTabla.setMetodoPreModificacion(this,"preModificacionRegTblTabla");
		tblTabla.setFuncionGrabar("p_graba");
		tblTabla.setFuncionPreModificacion("p_modifica(2)");
		tblTabla.setFuncionModificacion("p_actualiza(12)");
		tblTabla.setFuncionConsultar("p_query(4)");
		tblTabla.setFuncionActualizar("p_actualiza(12)");
		tblTabla.setFuncionPreActualizar("p_alta(1)");
		tblTabla.setFuncionRecuperar("p_devuelve(12)");
		tblTabla.setFuncionBorrar("p_borra(2)");
		tblTabla.setMenuOpciones("AP100360,1");
		tblTabla.setMetodoPostMenu(this,"posMenuTblTabla");
		//El metodo posMenuTblTabla debe estar definido en el area TG_CRP 
		tblTabla.setObjetoPosterior(pnlBotonAceptar);
		tblTabla.setTipoSeleccion("PRIMERO");
		tblTabla.setModoSeleccion("SOLO CONSULTA");
		tblTabla.setMultiregistro(false);
		tblTabla.setObjetoAnterior(pnlQuery0);
		tblTabla.setCodigoPackage("DC_K_AP100360");
		tblTabla.setLayout(new BoxLayout(tblTabla,BoxLayout.X_AXIS));
		pnlTabla.add(tblTabla, new com.symantec.itools.awt.GridBagConstraintsD(0,0,1,1,1.0,1.0,java.awt.GridBagConstraints.CENTER,java.awt.GridBagConstraints.VERTICAL,new Insets(0,0,0,0),0,-275));

//		clmIdnIntProc.setVisible(false);
		clmIdnIntProc.setReal(23);
		clmIdnIntProc.setTipoDato("NUMERICO");
		clmIdnIntProc.setPosicion(1);
		clmIdnIntProc.setModuloCodigo("trn,157");
		clmIdnIntProc.setVisibleLong(16);
		tblTabla.add(clmIdnIntProc);
		//clmIdnIntProc.setVisible(false);

		clmCodProc.setReal(23);
		clmCodProc.setTipoDato("TEXTO");
		clmCodProc.setPosicion(2);
		clmCodProc.setModuloCodigo("trn,32");
		clmCodProc.setVisibleLong(16);
//		clmCodProc.setVisible(false);
		tblTabla.add(clmCodProc);
		clmNomCodProc.setReal(23);
		clmNomCodProc.setTipoDato("TEXTO");
		clmNomCodProc.setPosicion(3);
		clmNomCodProc.setModuloCodigo("trn,94");
		clmNomCodProc.setVisibleLong(16);
		tblTabla.add(clmNomCodProc);		
		
		clmAliasProc.setReal(31);
		clmAliasProc.setTipoDato("TEXTO");
		clmAliasProc.setMayusculas(true);
		clmAliasProc.setPosicion(4);
		clmAliasProc.setModuloCodigo("trn,368");
		clmAliasProc.setVisibleLong(21);
		tblTabla.add(clmAliasProc);
//		clmAliasProc.setVisible(false);
		clmFecDesdeProc.setReal(9);
		clmFecDesdeProc.setTipoDato("dd-MM-yyyy");
		clmFecDesdeProc.setPosicion(5);
		clmFecDesdeProc.setModuloCodigo("trn,735");
		clmFecDesdeProc.setVisibleLong(11);
		tblTabla.add(clmFecDesdeProc);
		//clmFecDesdeProc.setVisible(false);
		clmFecHastaProc.setReal(9);
		clmFecHastaProc.setTipoDato("dd-MM-yyyy");
		clmFecHastaProc.setPosicion(6);
		clmFecHastaProc.setModuloCodigo("trn,736");
		clmFecHastaProc.setVisibleLong(11);
		tblTabla.add(clmFecHastaProc);
//		clmFecHastaProc.setVisible(false);
		clmTipSituProc.setReal(4);
		clmTipSituProc.setTipoDato("TEXTO");
		clmTipSituProc.setMayusculas(true);
		clmTipSituProc.setPosicion(8);
		clmTipSituProc.setModuloCodigo("trn,1825");
		clmTipSituProc.setVisibleLong(4);
		tblTabla.add(clmTipSituProc);
//		clmTipSituProc.setVisible(false);
		clmMcaEnviado.setReal(2);
		clmMcaEnviado.setTipoDato("BOOLEAN");
		clmMcaEnviado.setValorTrue("S");
		clmMcaEnviado.setValorFalse("N");
		clmMcaEnviado.setPosicion(7);
		clmMcaEnviado.setModuloCodigo("trn,1826");
		clmMcaEnviado.setVisibleLong(2);
		clmMcaEnviado.setEnabled(false);
		tblTabla.add(clmMcaEnviado);
//		clmMcaEnviado.setVisible(false);
		clmCodUsr.setReal(9);
		clmCodUsr.setTipoDato("TEXTO");
		clmCodUsr.setMayusculas(true);
		clmCodUsr.setPosicion(10);
		clmCodUsr.setModuloCodigo("trn,139");
		clmCodUsr.setVisibleLong(9);
		tblTabla.add(clmCodUsr);
//		clmCodUsr.setVisible(false);
		clmFecActu.setReal(9);
		clmFecActu.setTipoDato("dd-MM-yyyy");
		clmFecActu.setPosicion(11);
		clmFecActu.setModuloCodigo("trn,55");
		clmFecActu.setVisibleLong(11);
		tblTabla.add(clmFecActu);
//		clmFecActu.setVisible(false);
		pnlDetalle.setBorder(ttlSinTitulo);
		pnlDetalle.setOpaque(false);
		pnlDetalle.setLayout(new FlowLayout(FlowLayout.CENTER,5,5));
		pnlDatos1.add(BorderLayout.SOUTH, pnlDetalle);
		pnlDetalle1.setAlignmentX(0.498442F);
		pnlDetalle1.setOpaque(false);
		pnlDetalle1.setLayout(new BoxLayout(pnlDetalle1,BoxLayout.Y_AXIS));
		pnlDetalle.add(pnlDetalle1);
		pnlDetalleInfo0.setOpaque(false);
		pnlDetalleInfo0.setLayout(new FlowLayout(FlowLayout.LEFT,5,1));
		pnlDetalle1.add(pnlDetalleInfo0);
		sprDetalleNomTipSituProc.setPixelsSeparacion(0);
		pnlDetalleInfo0.add(sprDetalleNomTipSituProc);
		lblDetalleNomTipSituProc.setAnchura(-1);
		lblDetalleNomTipSituProc.setModuloCodigo("trn,1825");
		pnlDetalleInfo0.add(lblDetalleNomTipSituProc);
		txtDetalleNomTipSituProc.setNombreCampo("NomTipSituProc");
		txtDetalleNomTipSituProc.setTipoDato("TEXTO");
		txtDetalleNomTipSituProc.setLongitud("40,40");
		txtDetalleNomTipSituProc.setGranEdicion(true);
		txtDetalleNomTipSituProc.setPanelGrupo(pnlQuery);		
		txtDetalleNomTipSituProc.setToolTip("trn,1825");
		txtDetalleNomTipSituProc.setTipoAnchura("TABLA");
		txtDetalleNomTipSituProc.setEnabled(false);
		pnlDetalleInfo0.add(txtDetalleNomTipSituProc);
		pnlBotonAceptar.setGrupoAnterior(pnlTabla);
		pnlBotonAceptar.setMetodoTeclas(this,"null");
		pnlBotonAceptar.setOpaque(false);
		pnlBotonAceptar.setLayout(new FlowLayout(FlowLayout.RIGHT,5,2));
		pnlDatos.add(BorderLayout.SOUTH, pnlBotonAceptar);
		btnAceptar.setMetodoAccion(this,"accionBtnAceptar");
		btnAceptar.setModuloCodigo("trn,188");
		btnAceptar.setActionCommand("Ramo");
		btnAceptar.setEnabled(false);
		pnlBotonAceptar.add(btnAceptar);
		getContentPane().add(BorderLayout.SOUTH, brsEstado);
		//$$ ttlSinTitulo.move(0,561);
		//}}

		this.setAutoCommit(true);
		setFuncionInicio("DC_K_AP100360.p_inicio");
		this.setMetodoInicio(this,"preDlgQuery");
		tblTabla.ajustaAncho(785);
		tblTabla.setMascara(AP100360.FECDESDEPROC,"dd-MM-yyyy");
		tblTabla.setMascara(AP100360.FECHASTAPROC,"dd-MM-yyyy");
		tblTabla.setMascara(AP100360.FECACTU,"dd-MM-yyyy");
		//Escriba su codigo entre los comentarios TG_CNS
		//<<TG_CNS
		tblTabla.setMetodoPreMenu(this,"preMenuOpciones");
		tblTabla.setMetodoPostMenu(this,"postMenuOpciones");
		
		txtDetalleNomTipSituProc.setMetodoPreValidacion(this, "preActualizaTxtDetalle");
		txtDetalleNomTipSituProc.setFuncionValidacion("dc_k_ap100360.p_look_up_tip_situ_proc(2)");
		txtDetalleNomTipSituProc.setMetodoPostValidacion(this, "postActualizaTxtDetalle");
		
		//>>TG_CNS
	} // Fin del metodo init() 

	//{{DECLARE_CONTROLS
	mapfre.com.c.GUI.TPanel pnlBarrasHerramientas = new mapfre.com.c.GUI.TPanel();
	mapfre.com.c.GUI.TBarraHerramientas brhGeneral = new mapfre.com.c.GUI.TBarraHerramientas();
	mapfre.com.c.GUI.TBarraHerramientas brhMantenimientoEdicion = new mapfre.com.c.GUI.TBarraHerramientas();
	mapfre.com.c.GUI.TPanel pnlGeneral = new mapfre.com.c.GUI.TPanel();
	mapfre.com.c.GUI.TScrollPanel scrGeneral = new mapfre.com.c.GUI.TScrollPanel();
	mapfre.com.c.GUI.ImageTPanel pnlGeneral1 = new mapfre.com.c.GUI.ImageTPanel();
	mapfre.com.c.GUI.TPanel pnlQuery = new mapfre.com.c.GUI.TPanel();
	mapfre.com.c.GUI.TPanel pnlQuery0 = new mapfre.com.c.GUI.TPanel();
	mapfre.com.c.GUI.TPanel pnlDatos = new mapfre.com.c.GUI.TPanel();
	mapfre.com.c.GUI.TPanel pnlDatos1 = new mapfre.com.c.GUI.TPanel();
	mapfre.com.c.GUI.TPanel pnlTabla = new mapfre.com.c.GUI.TPanel();
	mapfre.com.c.GUI.TPanel pnlDetalle = new mapfre.com.c.GUI.TPanel();
	mapfre.com.c.GUI.TPanel pnlDetalle1 = new mapfre.com.c.GUI.TPanel();
	mapfre.com.c.GUI.TPanel pnlBotonAceptar = new mapfre.com.c.GUI.TPanel();
	mapfre.com.c.GUI.TButton btnAceptar = new mapfre.com.c.GUI.TButton();
	mapfre.com.c.GUI.TTitledBorder ttlSinTitulo = new mapfre.com.c.GUI.TTitledBorder();
	mapfre.com.c.GUI.TBarraEstado brsEstado = new mapfre.com.c.GUI.TBarraEstado();
	mapfre.com.c.GUI.TTablaEdicion tblTabla = new mapfre.com.c.GUI.TTablaEdicion();
	mapfre.com.c.GUI.TPanel pnlQueryInfo0 = new mapfre.com.c.GUI.TPanel ();
	mapfre.com.c.GUI.TPanel pnlQueryInfo1 = new mapfre.com.c.GUI.TPanel ();

	mapfre.com.c.GUI.TSeparador sprQueryCodProc = new mapfre.com.c.GUI.TSeparador();
	mapfre.com.c.GUI.TLabel lblQueryCodProc = new mapfre.com.c.GUI.TLabel();
	mapfre.com.c.GUI.TTextField txtQueryCodProc = new mapfre.com.c.GUI.TTextField();
	mapfre.com.c.GUI.TTextField txtQueryNomCodProc = new mapfre.com.c.GUI.TTextField();
	mapfre.com.c.GUI.TSeparador sprQueryIdnIntProc = new mapfre.com.c.GUI.TSeparador();
	mapfre.com.c.GUI.TLabel lblQueryIdnIntProc = new mapfre.com.c.GUI.TLabel();
	mapfre.com.c.GUI.TTextField txtQueryIdnIntProc = new mapfre.com.c.GUI.TTextField();
	mapfre.com.c.GUI.TSeparador sprQueryAliasProc = new mapfre.com.c.GUI.TSeparador();
	mapfre.com.c.GUI.TLabel lblQueryAliasProc = new mapfre.com.c.GUI.TLabel();
	mapfre.com.c.GUI.TTextField txtQueryAliasProc = new mapfre.com.c.GUI.TTextField();
	mapfre.com.c.GUI.TSeparador sprQueryFecProceso = new mapfre.com.c.GUI.TSeparador();
	mapfre.com.c.GUI.TLabel lblQueryFecProceso = new mapfre.com.c.GUI.TLabel();
	mapfre.com.c.GUI.TTextField txtQueryFecProceso = new mapfre.com.c.GUI.TTextField();
	mapfre.com.c.GUI.TSeparador sprConsultar = new mapfre.com.c.GUI.TSeparador();
	mapfre.com.c.GUI.TButton btnConsultar = new mapfre.com.c.GUI.TButton();
	mapfre.com.c.GUI.TPanel pnlDetalleInfo0 = new mapfre.com.c.GUI.TPanel ();
	mapfre.com.c.GUI.TSeparador sprDetalleNomTipSituProc = new mapfre.com.c.GUI.TSeparador();
	mapfre.com.c.GUI.TLabel lblDetalleNomTipSituProc = new mapfre.com.c.GUI.TLabel();
	mapfre.com.c.GUI.TTextField txtDetalleNomTipSituProc = new mapfre.com.c.GUI.TTextField();
	mapfre.com.c.GUI.TColumna clmIdnIntProc = new mapfre.com.c.GUI.TColumna();
	mapfre.com.c.GUI.TColumna clmCodProc = new mapfre.com.c.GUI.TColumna();
	mapfre.com.c.GUI.TColumna clmNomCodProc = new mapfre.com.c.GUI.TColumna();
	mapfre.com.c.GUI.TColumna clmAliasProc = new mapfre.com.c.GUI.TColumna();
	mapfre.com.c.GUI.TColumna clmFecDesdeProc = new mapfre.com.c.GUI.TColumna();
	mapfre.com.c.GUI.TColumna clmFecHastaProc = new mapfre.com.c.GUI.TColumna();
	mapfre.com.c.GUI.TColumna clmTipSituProc = new mapfre.com.c.GUI.TColumna();
	mapfre.com.c.GUI.TColumna clmMcaEnviado = new mapfre.com.c.GUI.TColumna();
	mapfre.com.c.GUI.TColumna clmCodUsr = new mapfre.com.c.GUI.TColumna();
	mapfre.com.c.GUI.TColumna clmFecActu = new mapfre.com.c.GUI.TColumna();
	//}}

	// Nombre de la clase que contiene el dialogo de mantenimiento de datos
	private static final String DLG_MANTENIMIENTO = "AP100360_1";

	// posiciones de los campos del registro en la tabla 
	protected static final int NUMSECUK = 0;
	protected static final int IDNINTPROC = 1;
	protected static final int CODPROC = 2;
	protected static final int NOMCODPROC = 3;
	protected static final int ALIASPROC = 4;
	protected static final int FECDESDEPROC = 5;
	protected static final int FECHASTAPROC = 6;
	protected static final int MCAENVIADO = 7;
	protected static final int TIPSITUPROC = 8;	
	protected static final int NOMTIPSITUPROC = 9;	
	protected static final int CODUSR = 10;
	protected static final int FECACTU = 11;
	
	private Object[] camposDetalle = {
	 txtDetalleNomTipSituProc
	};

	private int[] posicionTabla = {
	 AP100360.NOMTIPSITUPROC
	};
	private Object[] componentesQuery = {
		txtQueryIdnIntProc
		,txtQueryCodProc
		,txtQueryFecProceso
		,txtQueryAliasProc
	};
	public Object[] nombresComponentesQuery = {
		 "txtQueryIdnIntProc"
		,"txtQueryCodProc"
		,"txtQueryFecProceso"
		,"txtQueryAliasProc"
	};

	//====METODOS DEL MANTENIMIENTO DE TABLA=====
	
	protected Object[] getQuery()
	{
		return new Object [] {
		txtQueryIdnIntProc,"IN"
	, 	txtQueryCodProc,"IN"
	, 	txtQueryFecProceso,"IN"
	,	txtQueryAliasProc,"IN"		};
	}
	
	protected Object[] getPreAlta()
	{
		return new Object [] {
	 	"AP100360","IN"		};
	}
	
	protected Object[] getPreModificacion()
	{
		return new Object [] {
	 	tblTabla.getNumRegistroActivo(),"IN"
	,	"AP100360","IN"		};
	}
	
	protected Object[] getBorra()
	{
		return new Object [] {
	 	tblTabla.getNumRegistroActivo(),"IN"
	,	"AP100360","IN"		};
	}
//========================================================================================
	//METODOS QUE NECESITA TDialogQuery PARA OPERAR CORRECTAMENTE
	//los siguientes metodos son generados automaticamente y no deben
	//ser modificados por el programador

	//Recupera el nombre de la clase de la pantalla de imputacion
	protected String   getDlgMantenimiento() {return DLG_MANTENIMIENTO;}

	//Recupera la informacion para rellenar el detalle
	protected Object[] getDetalle() {return new Object [] {camposDetalle, posicionTabla};}

	//Recupera el panel de query
	protected TPanel   getPnlQuery() {return pnlQuery;}

	//Recupera el panel que contiene a la tabla
	protected TPanel   getPnlDatos() {return pnlDatos;}

	//Recupera el boton de aceptar
	protected TButton  getBtnAceptar() {return btnAceptar;}

	//Recupera el boton de consultar
	protected TButton  getBtnConsultar() {return btnConsultar;}

	//Recupera el panel general que contiene al resto
	protected TPanel   getPnlGeneral() {return pnlGeneral;}

	//Recupera los componentes del panel de query junto con sus nombres
	protected Object[] getComponentesQuery() {return new Object[] {componentesQuery,nombresComponentesQuery};}


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

	//Metodo para probar la clase
	public static void main (String[] args)
	{
		try
		{
			UIManager.setLookAndFeel(UIManager.getSystemLookAndFeelClassName());
		}
		catch (Exception e)
		{
		}
		AP100360 dlg = new AP100360();
		dlg.setVisible(true);
	}
	

	//Escriba su codigo entre los comentarios TG_CRP
	//<<TG_CRP
	public Boolean actInicio()
	{
	    if(espera==null)
	    {
	        espera = new TBarraEspera();
	        espera.setTexto(Globales.getCodigoMensaje("TRN",10512));
	    }
	    espera.iniciar();
	    return Boolean.TRUE;
	}
	public Boolean actFin()
	{
	    espera.detener();
	    return Boolean.TRUE;
	}

	public Boolean postMenuOpciones()    
	{
	   TTextField txtValidacion = new TTextField();
	   TTextField txtHayError   = new TTextField();
	   int respuesta ;
	   if (!"0".equals(this.getOpcionMenu())) 
	   {
		   if(getTabla().isHuboCambiosLocales())
		   {
			   Herramientas.mostrarMensaje("trn","23000001",Herramientas.DIALOGOACEPTAR,this);
			   return Boolean.FALSE;
		   }
			   
		   respuesta = Herramientas.SI;
		   actInicio();
           
		   if (respuesta == Herramientas.SI){
			   txtValidacion.setFuncionValidacion("dc_k_ap100360.p_inicio_procesamiento(3)");			   
			   txtValidacion.addParametro(this.tblTabla.getValor(this.tblTabla.getNumFilaActiva(), 0), "IN", 0, 3);
			   txtValidacion.addParametro(this.getOpcionMenu(), "IN", 1, 3);
			   txtValidacion.addParametro(txtHayError, "IN OUT", 2, 3);
               if (txtValidacion.lanzaValidacionOracle())
			   {
				   if(txtHayError.getText().equals("A")) 
				   {
					   // DATOS GENERADOS
					   Herramientas.mostrarMensaje("trn","10532", Herramientas.DIALOGOACEPTAR, this); 
				   }
				   else if(txtHayError.getText().equals("B"))
				   {
					   // GENERACION DE DATOS TERMINADO CON ERRORES. LISTAR ERRORES
					   Herramientas.mostrarMensaje("trn","10534", Herramientas.DIALOGOACEPTAR, this); 
				   } 
				   else if(txtHayError.getText().equals("C")) 
				   {
					   // LISTADO GENERADO
					   Herramientas.mostrarMensaje("trn","10513", Herramientas.DIALOGOACEPTAR, this); 
				   }
				   else if(txtHayError.getText().equals("D"))
				   {
					   // GENERACION DE FICHEROS TERMINADO CON ERRORES. LISTAR ERRORES
					   Herramientas.mostrarMensaje("trn","10533", Herramientas.DIALOGOACEPTAR, this);
				   }
				   else if(txtHayError.getText().equals("E"))
				   {
					   // HISTORIFICACION CREADA
					   Herramientas.mostrarMensaje("trn","10530", Herramientas.DIALOGOACEPTAR, this);
					   ControlTeclas.teclaSalir(this);

				   }
				   else if(txtHayError.getText().equals("F"))
				   {
					   // ERROR DE HISTORIFICACION
					   Herramientas.mostrarMensaje("trn","10531", Herramientas.DIALOGOACEPTAR, this);
				   }
				   else if(txtHayError.getText().equals("L"))
				   {
					   //EJECUCION EN PROCESO... ESPERE POR FAVOR
					   Herramientas.mostrarMensaje("trn","10512", Herramientas.DIALOGOACEPTAR, this);
				   }
				   else
				   {
					   Herramientas.mostrarMensaje("trn","20013", Herramientas.DIALOGOACEPTAR, this);					   
				   }
			   }
			   			   
			   int filaActiva = this.tblTabla.getNumFilaActiva();
			   tblTabla.ejecutarConsulta();
			   tblTabla.setCeldaActiva(filaActiva, 0);
			   			   
			   this.tblTabla.getJTable().requestFocus();
			   txtDetalleNomTipSituProc.lanzaValidacionOracle();
			   actFin();
		   }		   
	   }
                    
	   return Boolean.TRUE;  
	}	
	
	public Boolean preActualizaTxtDetalle()    
	{		   		   
		   txtDetalleNomTipSituProc.addParametro(tblTabla.getValor(this.tblTabla.getNumFilaActiva(), 4), "IN", 0, 2);
		   txtDetalleNomTipSituProc.addParametro(txtDetalleNomTipSituProc, "IN OUT", 1, 2);		   
		   		
		return Boolean.TRUE;
	}
	
	public Boolean postActualizaTxtDetalle()    
	{

		   if (txtDetalleNomTipSituProc.getText().equals("")) 
		   {
			   return Boolean.FALSE;
		   }
		
		return Boolean.TRUE;
	}
	
	//>>TG_CRP
} //Fin de la clase

