-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 23-01-2024 a las 17:31:40
-- Versión del servidor: 10.4.28-MariaDB
-- Versión de PHP: 8.0.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `dbpunto_ventaaaa`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ModificarCategoria` (IN `p_IdCategoria` INT, IN `p_Descripcion` VARCHAR(50), OUT `p_Resultado` BIT)   BEGIN
    SET p_Resultado = 1;

    IF NOT EXISTS (SELECT * FROM CATEGORIA WHERE Descripcion = p_Descripcion AND IdCategoria != p_IdCategoria) THEN
        UPDATE CATEGORIA SET
            Descripcion = p_Descripcion
        WHERE IdCategoria = p_IdCategoria;
    ELSE
        SET p_Resultado = 0;
    END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ModificarPersona` (IN `p_IdPersona` INT, IN `p_Documento` VARCHAR(50), IN `p_Nombre` VARCHAR(50), IN `p_Direccion` VARCHAR(50), IN `p_Telefono` VARCHAR(50), IN `p_Clave` VARCHAR(50), IN `p_IdTipoPersona` INT, OUT `p_Resultado` BIT)   BEGIN
    SET p_Resultado = 1;

    IF NOT EXISTS (SELECT * FROM PERSONA WHERE Documento = p_Documento AND IdPersona != p_IdPersona) THEN
        UPDATE PERSONA SET
            Documento = p_Documento,
            Nombre = p_Nombre,
            Direccion = p_Direccion,
            Telefono = p_Telefono,
            IdTipoPersona = p_IdTipoPersona
        WHERE IdPersona = p_IdPersona;
    ELSE
        SET p_Resultado = 0;
    END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ModificarProducto` (IN `p_IdProducto` INT, IN `p_Codigo` VARCHAR(20), IN `p_Nombre` VARCHAR(30), IN `p_Descripcion` VARCHAR(30), IN `p_IdCategoria` INT, OUT `p_Resultado` BIT)   BEGIN
    SET p_Resultado = 1;

    IF NOT EXISTS (SELECT * FROM PRODUCTO WHERE Codigo = p_Codigo AND IdProducto != p_IdProducto) THEN
        UPDATE PRODUCTO SET
            Codigo = p_Codigo,
            Nombre = p_Nombre,
            Descripcion = p_Descripcion,
            IdCategoria = p_IdCategoria
        WHERE IdProducto = p_IdProducto;
    ELSE
        SET p_Resultado = 0;
    END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ModificarProveedor` (IN `p_IdProveedor` INT, IN `p_Documento` VARCHAR(50), IN `p_RazonSocial` VARCHAR(50), IN `p_Correo` VARCHAR(50), IN `p_Telefono` VARCHAR(50), OUT `p_Resultado` BIT)   BEGIN
    SET p_Resultado = 1;

    IF NOT EXISTS (SELECT * FROM PROVEEDOR WHERE Documento = p_Documento AND IdProveedor != p_IdProveedor) THEN
        UPDATE PROVEEDOR SET
            Documento = p_Documento,
            RazonSocial = p_RazonSocial,
            Correo = p_Correo,
            Telefono = p_Telefono
        WHERE IdProveedor = p_IdProveedor;
    ELSE
        SET p_Resultado = 0;
    END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_RegistrarCategoria` (IN `p_Descripcion` VARCHAR(50), OUT `p_Resultado` INT)   BEGIN
    DECLARE l_IDCATEGORIA INT;

    SET p_Resultado = 0;

    SELECT IdCategoria INTO l_IDCATEGORIA FROM CATEGORIA WHERE Descripcion = p_Descripcion LIMIT 1;

    IF l_IDCATEGORIA IS NULL THEN
        INSERT INTO CATEGORIA(Descripcion) VALUES (p_Descripcion);

        SET p_Resultado = LAST_INSERT_ID();
    END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_RegistrarPersona` (IN `p_Documento` VARCHAR(50), IN `p_Nombre` VARCHAR(50), IN `p_Direccion` VARCHAR(50), IN `p_Telefono` VARCHAR(50), IN `p_Clave` VARCHAR(50), IN `p_IdTipoPersona` INT, OUT `p_Resultado` INT)   BEGIN
    DECLARE l_IDPERSONA INT;

    SET p_Resultado = 0;

    SELECT IdPersona INTO l_IDPERSONA FROM PERSONA WHERE Documento = p_Documento LIMIT 1;

    IF l_IDPERSONA IS NULL THEN
        INSERT INTO PERSONA(Documento, Nombre, Direccion, Telefono, Clave, IdTipoPersona) VALUES (
            p_Documento, p_Nombre, p_Direccion, p_Telefono, p_Clave, p_IdTipoPersona
        );

        SET p_Resultado = LAST_INSERT_ID();
    END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_RegistrarProducto` (IN `p_Codigo` VARCHAR(20), IN `p_Nombre` VARCHAR(30), IN `p_Descripcion` VARCHAR(30), IN `p_IdCategoria` INT, OUT `p_Resultado` INT)   BEGIN
    SET p_Resultado = 0;
    
    IF NOT EXISTS (SELECT * FROM PRODUCTO WHERE Codigo = p_Codigo) THEN
        INSERT INTO PRODUCTO(Codigo, Nombre, Descripcion, IdCategoria) VALUES (
            p_Codigo, p_Nombre, p_Descripcion, p_IdCategoria
        );

        SET p_Resultado = LAST_INSERT_ID();
    END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_RegistrarProveedor` (IN `p_Documento` VARCHAR(50), IN `p_RazonSocial` VARCHAR(50), IN `p_Correo` VARCHAR(50), IN `p_Telefono` VARCHAR(50), OUT `p_Resultado` INT)   BEGIN
    DECLARE l_IDPROVEEDOR INT;

    SET p_Resultado = 0;

    SELECT IdProveedor INTO l_IDPROVEEDOR FROM PROVEEDOR WHERE Documento = p_Documento LIMIT 1;

    IF l_IDPROVEEDOR IS NULL THEN
        INSERT INTO PROVEEDOR(Documento, RazonSocial, Correo, Telefono) VALUES (
            p_Documento, p_RazonSocial, p_Correo, p_Telefono
        );

        SET p_Resultado = LAST_INSERT_ID();
    END IF;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categoria`
--

CREATE TABLE `categoria` (
  `IdCategoria` int(11) NOT NULL,
  `Descripcion` varchar(15) DEFAULT NULL,
  `Estado` tinyint(1) DEFAULT 1,
  `FechaCreacion` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `compra`
--

CREATE TABLE `compra` (
  `IdCompra` int(11) NOT NULL,
  `IdPersona` int(11) DEFAULT NULL,
  `IdProveedor` int(11) DEFAULT NULL,
  `MontoTotal` decimal(10,2) DEFAULT 0.00,
  `TipoDocumento` varchar(50) DEFAULT 'Boleta',
  `NumeroDocumento` varchar(50) DEFAULT NULL,
  `FechaRegistro` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_compra`
--

CREATE TABLE `detalle_compra` (
  `IdDetalleCompra` int(11) NOT NULL,
  `IdCompra` int(11) DEFAULT NULL,
  `IdProducto` int(11) DEFAULT NULL,
  `Cantidad` int(11) DEFAULT NULL,
  `PrecioCompra` decimal(10,2) DEFAULT NULL,
  `PrecioVenta` decimal(10,2) DEFAULT NULL,
  `Total` decimal(10,2) DEFAULT NULL,
  `FechaRegistro` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_venta`
--

CREATE TABLE `detalle_venta` (
  `IdDetalleVenta` int(11) NOT NULL,
  `IdVenta` int(11) DEFAULT NULL,
  `IdProducto` int(11) DEFAULT NULL,
  `Cantidad` int(11) DEFAULT NULL,
  `PrecioVenta` decimal(10,2) DEFAULT NULL,
  `SubTotal` decimal(10,2) DEFAULT NULL,
  `FechaRegistro` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `persona`
--

CREATE TABLE `persona` (
  `IdPersona` int(11) NOT NULL,
  `Documento` varchar(15) DEFAULT NULL,
  `Nombre` varchar(50) DEFAULT NULL,
  `Direccion` varchar(50) DEFAULT NULL,
  `Telefono` varchar(50) DEFAULT NULL,
  `Clave` varchar(50) DEFAULT NULL,
  `IdTipoPersona` int(11) DEFAULT NULL,
  `Estado` tinyint(1) DEFAULT 1,
  `FechaCreacion` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `persona`
--

INSERT INTO `persona` (`IdPersona`, `Documento`, `Nombre`, `Direccion`, `Telefono`, `Clave`, `IdTipoPersona`, `Estado`, `FechaCreacion`) VALUES
(1, '10101010', 'Admin', NULL, NULL, '123', 1, 1, '2024-01-16 23:47:32'),
(2, '20202020', 'Empleado', NULL, NULL, '456', 2, 1, '2024-01-16 23:47:32');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `producto`
--

CREATE TABLE `producto` (
  `IdProducto` int(11) NOT NULL,
  `Codigo` varchar(20) DEFAULT NULL,
  `Nombre` varchar(30) DEFAULT NULL,
  `Descripcion` varchar(30) DEFAULT NULL,
  `IdCategoria` int(11) DEFAULT NULL,
  `Stock` int(11) DEFAULT 0,
  `PrecioCompra` decimal(10,2) DEFAULT 0.00,
  `PrecioVenta` decimal(10,2) DEFAULT 0.00,
  `Estado` tinyint(1) DEFAULT 1,
  `FechaCreacion` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `proveedor`
--

CREATE TABLE `proveedor` (
  `IdProveedor` int(11) NOT NULL,
  `Documento` varchar(15) DEFAULT NULL,
  `RazonSocial` varchar(50) DEFAULT NULL,
  `Correo` varchar(50) DEFAULT NULL,
  `Telefono` varchar(50) DEFAULT NULL,
  `Estado` tinyint(1) DEFAULT 1,
  `FechaCreacion` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tienda`
--

CREATE TABLE `tienda` (
  `IdTienda` int(11) NOT NULL,
  `Documento` varchar(50) DEFAULT NULL,
  `RazonSocial` varchar(50) DEFAULT NULL,
  `Correo` varchar(50) DEFAULT NULL,
  `Telefono` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tienda`
--

INSERT INTO `tienda` (`IdTienda`, `Documento`, `RazonSocial`, `Correo`, `Telefono`) VALUES
(1, '0', 'POR DEFINIR', 'DEFAULT@GMAIL.COM', '101010');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_persona`
--

CREATE TABLE `tipo_persona` (
  `IdTipoPersona` int(11) NOT NULL,
  `Descripcion` varchar(50) DEFAULT NULL,
  `Estado` tinyint(1) DEFAULT 1,
  `FechaCreacion` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tipo_persona`
--

INSERT INTO `tipo_persona` (`IdTipoPersona`, `Descripcion`, `Estado`, `FechaCreacion`) VALUES
(1, 'Administrador', 1, '2024-01-16 23:47:31'),
(2, 'Empleado', 1, '2024-01-16 23:47:31'),
(3, 'Cliente', 1, '2024-01-16 23:47:31');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `venta`
--

CREATE TABLE `venta` (
  `IdVenta` int(11) NOT NULL,
  `TipoDocumento` varchar(50) DEFAULT NULL,
  `NumeroDocumento` varchar(100) DEFAULT NULL,
  `IdUsuario` int(11) DEFAULT NULL,
  `DocumentoCliente` varchar(50) DEFAULT NULL,
  `NombreCliente` varchar(50) DEFAULT NULL,
  `TotalPagar` decimal(10,2) DEFAULT NULL,
  `PagoCon` decimal(10,2) DEFAULT NULL,
  `Cambio` decimal(10,2) DEFAULT NULL,
  `FechaRegistro` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `categoria`
--
ALTER TABLE `categoria`
  ADD PRIMARY KEY (`IdCategoria`);

--
-- Indices de la tabla `compra`
--
ALTER TABLE `compra`
  ADD PRIMARY KEY (`IdCompra`),
  ADD KEY `IdPersona` (`IdPersona`),
  ADD KEY `IdProveedor` (`IdProveedor`);

--
-- Indices de la tabla `detalle_compra`
--
ALTER TABLE `detalle_compra`
  ADD PRIMARY KEY (`IdDetalleCompra`),
  ADD KEY `IdCompra` (`IdCompra`),
  ADD KEY `IdProducto` (`IdProducto`);

--
-- Indices de la tabla `detalle_venta`
--
ALTER TABLE `detalle_venta`
  ADD PRIMARY KEY (`IdDetalleVenta`),
  ADD KEY `IdVenta` (`IdVenta`),
  ADD KEY `IdProducto` (`IdProducto`);

--
-- Indices de la tabla `persona`
--
ALTER TABLE `persona`
  ADD PRIMARY KEY (`IdPersona`),
  ADD KEY `IdTipoPersona` (`IdTipoPersona`);

--
-- Indices de la tabla `producto`
--
ALTER TABLE `producto`
  ADD PRIMARY KEY (`IdProducto`),
  ADD KEY `IdCategoria` (`IdCategoria`);

--
-- Indices de la tabla `proveedor`
--
ALTER TABLE `proveedor`
  ADD PRIMARY KEY (`IdProveedor`);

--
-- Indices de la tabla `tienda`
--
ALTER TABLE `tienda`
  ADD PRIMARY KEY (`IdTienda`);

--
-- Indices de la tabla `tipo_persona`
--
ALTER TABLE `tipo_persona`
  ADD PRIMARY KEY (`IdTipoPersona`);

--
-- Indices de la tabla `venta`
--
ALTER TABLE `venta`
  ADD PRIMARY KEY (`IdVenta`),
  ADD KEY `IdUsuario` (`IdUsuario`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `categoria`
--
ALTER TABLE `categoria`
  MODIFY `IdCategoria` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `compra`
--
ALTER TABLE `compra`
  MODIFY `IdCompra` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `detalle_compra`
--
ALTER TABLE `detalle_compra`
  MODIFY `IdDetalleCompra` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `detalle_venta`
--
ALTER TABLE `detalle_venta`
  MODIFY `IdDetalleVenta` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `persona`
--
ALTER TABLE `persona`
  MODIFY `IdPersona` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `producto`
--
ALTER TABLE `producto`
  MODIFY `IdProducto` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `proveedor`
--
ALTER TABLE `proveedor`
  MODIFY `IdProveedor` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `venta`
--
ALTER TABLE `venta`
  MODIFY `IdVenta` int(11) NOT NULL AUTO_INCREMENT;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `compra`
--
ALTER TABLE `compra`
  ADD CONSTRAINT `compra_ibfk_1` FOREIGN KEY (`IdPersona`) REFERENCES `persona` (`IdPersona`),
  ADD CONSTRAINT `compra_ibfk_2` FOREIGN KEY (`IdProveedor`) REFERENCES `proveedor` (`IdProveedor`);

--
-- Filtros para la tabla `detalle_compra`
--
ALTER TABLE `detalle_compra`
  ADD CONSTRAINT `detalle_compra_ibfk_1` FOREIGN KEY (`IdCompra`) REFERENCES `compra` (`IdCompra`),
  ADD CONSTRAINT `detalle_compra_ibfk_2` FOREIGN KEY (`IdProducto`) REFERENCES `producto` (`IdProducto`);

--
-- Filtros para la tabla `detalle_venta`
--
ALTER TABLE `detalle_venta`
  ADD CONSTRAINT `detalle_venta_ibfk_1` FOREIGN KEY (`IdVenta`) REFERENCES `venta` (`IdVenta`),
  ADD CONSTRAINT `detalle_venta_ibfk_2` FOREIGN KEY (`IdProducto`) REFERENCES `producto` (`IdProducto`);

--
-- Filtros para la tabla `persona`
--
ALTER TABLE `persona`
  ADD CONSTRAINT `persona_ibfk_1` FOREIGN KEY (`IdTipoPersona`) REFERENCES `tipo_persona` (`IdTipoPersona`);

--
-- Filtros para la tabla `producto`
--
ALTER TABLE `producto`
  ADD CONSTRAINT `producto_ibfk_1` FOREIGN KEY (`IdCategoria`) REFERENCES `categoria` (`IdCategoria`);

--
-- Filtros para la tabla `venta`
--
ALTER TABLE `venta`
  ADD CONSTRAINT `venta_ibfk_1` FOREIGN KEY (`IdUsuario`) REFERENCES `persona` (`IdPersona`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
