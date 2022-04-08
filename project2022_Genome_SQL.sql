-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Project2022_GenomicBD
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `Project2022_GenomicBD` ;

-- -----------------------------------------------------
-- Schema Project2022_GenomicBD
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Project2022_GenomicBD` DEFAULT CHARACTER SET utf8 ;
USE `Project2022_GenomicBD` ;

-- -----------------------------------------------------
-- Table `Project2022_GenomicBD`.`Organism`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Project2022_GenomicBD`.`Organism` ;

CREATE TABLE IF NOT EXISTS `Project2022_GenomicBD`.`Organism` (
  `idOrganism` INT NOT NULL AUTO_INCREMENT,
  `Common name` VARCHAR(45) NULL,
  `Family` VARCHAR(45) NULL,
  `Spieces` VARCHAR(65) NOT NULL,
  PRIMARY KEY (`idOrganism`),
  UNIQUE INDEX `idOrganism_UNIQUE` (`idOrganism` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 1;


-- -----------------------------------------------------
-- Table `Project2022_GenomicBD`.`Genome`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Project2022_GenomicBD`.`Genome` ;

CREATE TABLE IF NOT EXISTS `Project2022_GenomicBD`.`Genome` (
  `idGenome` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(45) NOT NULL DEFAULT 'Unnamed',
  `Assembly` VARCHAR(45) NOT NULL,
  `Release_date` DATE NULL,
  `Release number` INT NOT NULL DEFAULT -1,
  `Organism_idOrganism` INT NOT NULL,
  PRIMARY KEY (`idGenome`),
  UNIQUE INDEX `idGenoma_UNIQUE` (`idGenome` ASC) VISIBLE,
  INDEX `fk_Genome_Organism_idx` (`Organism_idOrganism` ASC) VISIBLE,
  CONSTRAINT `fk_Genome_Organism`
    FOREIGN KEY (`Organism_idOrganism`)
    REFERENCES `Project2022_GenomicBD`.`Organism` (`idOrganism`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 1;


-- -----------------------------------------------------
-- Table `Project2022_GenomicBD`.`Gene`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Project2022_GenomicBD`.`Gene` ;

CREATE TABLE IF NOT EXISTS `Project2022_GenomicBD`.`Gene` (
  `idGene` INT NOT NULL AUTO_INCREMENT,
  `Location_start` INT NOT NULL DEFAULT 0,
  `Location_end` INT NOT NULL,
  `Sequence` LONGTEXT NOT NULL,
  `Description` VARCHAR(200) NULL,
  `Author` MEDIUMTEXT NULL,
  PRIMARY KEY (`idGene`),
  UNIQUE INDEX `idGene_UNIQUE` (`idGene` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 1;


-- -----------------------------------------------------
-- Table `Project2022_GenomicBD`.`Book`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Project2022_GenomicBD`.`Book` ;

CREATE TABLE IF NOT EXISTS `Project2022_GenomicBD`.`Book` (
  `idBook` INT NOT NULL AUTO_INCREMENT,
  `Title` VARCHAR(250) NOT NULL DEFAULT 'Untitled',
  `Author` VARCHAR(500) NOT NULL DEFAULT 'Anonymus',
  `Description` LONGTEXT NULL,
  PRIMARY KEY (`idBook`))
ENGINE = InnoDB
AUTO_INCREMENT = 1;


-- -----------------------------------------------------
-- Table `Project2022_GenomicBD`.`Bookshelf`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Project2022_GenomicBD`.`Bookshelf` ;

CREATE TABLE IF NOT EXISTS `Project2022_GenomicBD`.`Bookshelf` (
  `Genome_idGenome` INT NOT NULL,
  `Book_idBook` INT NOT NULL,
  PRIMARY KEY (`Genome_idGenome`, `Book_idBook`),
  INDEX `fk_Bookshelf_Book1_idx` (`Book_idBook` ASC) VISIBLE)
ENGINE = BLACKHOLE
COMMENT = 'B';


-- -----------------------------------------------------
-- Table `Project2022_GenomicBD`.`Chromosome`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Project2022_GenomicBD`.`Chromosome` ;

CREATE TABLE IF NOT EXISTS `Project2022_GenomicBD`.`Chromosome` (
  `Gene_idGene` INT NOT NULL,
  `ChromosomeNum` INT NOT NULL,
  `Genome_idGenome` INT NOT NULL,
  PRIMARY KEY (`Gene_idGene`, `Genome_idGenome`),
  INDEX `fk_Genome_has_Gene_Gene1_idx` (`Gene_idGene` ASC) VISIBLE,
  INDEX `fk_Chromosome_Genome1_idx` (`Genome_idGenome` ASC) VISIBLE,
  CONSTRAINT `fk_Genome_has_Gene_Gene1`
    FOREIGN KEY (`Gene_idGene`)
    REFERENCES `Project2022_GenomicBD`.`Gene` (`idGene`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Chromosome_Genome1`
    FOREIGN KEY (`Genome_idGenome`)
    REFERENCES `Project2022_GenomicBD`.`Genome` (`idGenome`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Project2022_GenomicBD`.`Protein`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Project2022_GenomicBD`.`Protein` ;

CREATE TABLE IF NOT EXISTS `Project2022_GenomicBD`.`Protein` (
  `idProtein` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(45) NOT NULL,
  `Function` VARCHAR(200) NULL DEFAULT 'Unknown',
  `Transcript` LONGTEXT NULL,
  `Proteincol` VARCHAR(45) NULL,
  `Gene_idGene` INT NOT NULL,
  PRIMARY KEY (`idProtein`, `Gene_idGene`),
  INDEX `fk_Protein_Gene1_idx` (`Gene_idGene` ASC) VISIBLE,
  CONSTRAINT `fk_Protein_Gene1`
    FOREIGN KEY (`Gene_idGene`)
    REFERENCES `Project2022_GenomicBD`.`Gene` (`idGene`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 1;


-- -----------------------------------------------------
-- Table `Project2022_GenomicBD`.`Sequence`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Project2022_GenomicBD`.`Sequence` ;

CREATE TABLE IF NOT EXISTS `Project2022_GenomicBD`.`Sequence` (
  `RefSeq` INT NOT NULL AUTO_INCREMENT,
  `Sequence` LONGTEXT NOT NULL,
  `Type` VARCHAR(45) NULL DEFAULT 'Unknown',
  `Size` INT NULL,
  `Anomaly` VARCHAR(200) NULL,
  `Gene_idGene` INT NOT NULL,
  `Protein_idProtein` INT NOT NULL,
  PRIMARY KEY (`RefSeq`, `Gene_idGene`, `Protein_idProtein`),
  UNIQUE INDEX `RefSeq_UNIQUE` (`RefSeq` ASC) VISIBLE,
  INDEX `fk_Sequence_Gene1_idx` (`Gene_idGene` ASC) VISIBLE,
  INDEX `fk_Sequence_Protein1_idx` (`Protein_idProtein` ASC) VISIBLE,
  CONSTRAINT `fk_Sequence_Gene1`
    FOREIGN KEY (`Gene_idGene`)
    REFERENCES `Project2022_GenomicBD`.`Gene` (`idGene`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Sequence_Protein1`
    FOREIGN KEY (`Protein_idProtein`)
    REFERENCES `Project2022_GenomicBD`.`Protein` (`idProtein`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 1;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `Project2022_GenomicBD`.`Organism`
-- -----------------------------------------------------
START TRANSACTION;
USE `Project2022_GenomicBD`;
INSERT INTO `Project2022_GenomicBD`.`Organism` (`idOrganism`, `Common name`, `Family`, `Spieces`) VALUES (1, 'human', 'Homininae', 'Homo sapiens');
INSERT INTO `Project2022_GenomicBD`.`Organism` (`idOrganism`, `Common name`, `Family`, `Spieces`) VALUES (2, 'mouse', 'Murinae', 'Mus musculus');
INSERT INTO `Project2022_GenomicBD`.`Organism` (`idOrganism`, `Common name`, `Family`, `Spieces`) VALUES (3, 'dog', 'Laurasiatheria', 'Canis lupus');
INSERT INTO `Project2022_GenomicBD`.`Organism` (`idOrganism`, `Common name`, `Family`, `Spieces`) VALUES (4, 'cattle', 'Bovidae', 'Bos taurus');
INSERT INTO `Project2022_GenomicBD`.`Organism` (`idOrganism`, `Common name`, `Family`, `Spieces`) VALUES (5, 'sheep', 'Bovidae', 'Ovis aries');
INSERT INTO `Project2022_GenomicBD`.`Organism` (`idOrganism`, `Common name`, `Family`, `Spieces`) VALUES (6, 'fruit fly', 'Diptera', 'Drosophila melanogaster');
INSERT INTO `Project2022_GenomicBD`.`Organism` (`idOrganism`, `Common name`, `Family`, `Spieces`) VALUES (7, 'nematode', 'Ecdysozoa', 'Caenorhabditis');
INSERT INTO `Project2022_GenomicBD`.`Organism` (`idOrganism`, `Common name`, `Family`, `Spieces`) VALUES (8, 'arabidopsis', 'rosids', 'Arabidopsis thaliana');
INSERT INTO `Project2022_GenomicBD`.`Organism` (`idOrganism`, `Common name`, `Family`, `Spieces`) VALUES (9, 'zebrafish', 'Euteleostomi', 'Danio rerio');
INSERT INTO `Project2022_GenomicBD`.`Organism` (`idOrganism`, `Common name`, `Family`, `Spieces`) VALUES (10, 'rice', 'Poaceae', 'Oryza sativa');

COMMIT;


-- -----------------------------------------------------
-- Data for table `Project2022_GenomicBD`.`Genome`
-- -----------------------------------------------------
START TRANSACTION;
USE `Project2022_GenomicBD`;
INSERT INTO `Project2022_GenomicBD`.`Genome` (`idGenome`, `Name`, `Assembly`, `Release_date`, `Release number`, `Organism_idOrganism`) VALUES (1, 'Homo sapiens', 'GRCh38.p14', '2021-11-22', 109, 1);
INSERT INTO `Project2022_GenomicBD`.`Genome` (`idGenome`, `Name`, `Assembly`, `Release_date`, `Release number`, `Organism_idOrganism`) VALUES (2, 'Mus musculus', 'GRCm39', '2020-09-22', 109, 2);
INSERT INTO `Project2022_GenomicBD`.`Genome` (`idGenome`, `Name`, `Assembly`, `Release_date`, `Release number`, `Organism_idOrganism`) VALUES (3, 'Canis lupus', 'ROS_Cfam_1.0', '2021-01-08', 106, 3);
INSERT INTO `Project2022_GenomicBD`.`Genome` (`idGenome`, `Name`, `Assembly`, `Release_date`, `Release number`, `Organism_idOrganism`) VALUES (4, 'Bos taurus', 'ARS-UCD1.2', '2018-05-11', 106, 4);
INSERT INTO `Project2022_GenomicBD`.`Genome` (`idGenome`, `Name`, `Assembly`, `Release_date`, `Release number`, `Organism_idOrganism`) VALUES (5, 'Ovis aries', 'ARS-UI_Ramb_v2.0', '2021-06-03', 104, 5);
INSERT INTO `Project2022_GenomicBD`.`Genome` (`idGenome`, `Name`, `Assembly`, `Release_date`, `Release number`, `Organism_idOrganism`) VALUES (6, 'Drosophila melanogaster', 'RELEASE 6 plus ISO1 MT', '2014-08-08', DEFAULT, 6);
INSERT INTO `Project2022_GenomicBD`.`Genome` (`idGenome`, `Name`, `Assembly`, `Release_date`, `Release number`, `Organism_idOrganism`) VALUES (7, 'Caenorhabditis elegantus', 'WBcel235', '2013-03-04', DEFAULT, 7);
INSERT INTO `Project2022_GenomicBD`.`Genome` (`idGenome`, `Name`, `Assembly`, `Release_date`, `Release number`, `Organism_idOrganism`) VALUES (8, 'Arabidopsis thaliana', 'TAIR10.1', '2018-06-04', DEFAULT, 8);
INSERT INTO `Project2022_GenomicBD`.`Genome` (`idGenome`, `Name`, `Assembly`, `Release_date`, `Release number`, `Organism_idOrganism`) VALUES (9, 'Danio rerio', 'GRCz11', '2017-06-26', 106, 9);
INSERT INTO `Project2022_GenomicBD`.`Genome` (`idGenome`, `Name`, `Assembly`, `Release_date`, `Release number`, `Organism_idOrganism`) VALUES (10, 'Oryza sativa', 'IRGSP-1.0', '2018-08-07', 102, 10);

COMMIT;


-- -----------------------------------------------------
-- Data for table `Project2022_GenomicBD`.`Book`
-- -----------------------------------------------------
START TRANSACTION;
USE `Project2022_GenomicBD`;
INSERT INTO `Project2022_GenomicBD`.`Book` (`idBook`, `Title`, `Author`, `Description`) VALUES (1, 'Whole genome sequencing', 'Pauline C Ng, Ewen F Kirkness', 'Whole genome sequencing provides the most comprehensive collection of an individual\'s genetic variation. With the falling costs of sequencing technology, we envision paradigm shift from microarray-based genotyping studies to whole genome sequencing. We review methodologies for whole genome sequencing. There are two approaches for assembling short shotgun sequence reads into longer contiguous genomic sequences. In the de novo assembly approach, sequence reads are compared to each other, and then overlapped to build longer contiguous sequences. The reference-based assembly approach involves mapping each read to a reference genome sequence. We discuss methods for identifying genetic variation (single nucleotide polymorphisms, small indels, and copy number variants) and building haplotypes from genome assemblies, and discuss potential pitfalls. We expect methodologies to evolve rapidly as sequencing technologies improve and more human genomes are sequenced.');
INSERT INTO `Project2022_GenomicBD`.`Book` (`idBook`, `Title`, `Author`, `Description`) VALUES (2, 'Integrating sequencing technologies in personal genomics: optimal low cost reconstruction of structural variants', 'Jiang Du, Robert D Bjornson, Zhengdong D Zhang, Yong Kong, Michael Snyder, Mark B Gerstein', 'The goal of human genome re-sequencing is obtaining an accurate assembly of an individual\'s genome. Recently, there has been great excitement in the development of many technologies for this (e.g. medium and short read sequencing from companies such as 454 and SOLiD, and high-density oligo-arrays from Affymetrix and NimbelGen), with even more expected to appear. The costs and sensitivities of these technologies differ considerably from each other. As an important goal of personal genomics is to reduce the cost of re-sequencing to an affordable point, it is worthwhile to consider optimally integrating technologies. Here, we build a simulation toolbox that will help us optimally combine different technologies for genome re-sequencing, especially in reconstructing large structural variants (SVs). SV reconstruction is considered the most challenging step in human genome re-sequencing. (It is sometimes even harder than de novo assembly of small genomes because of the duplications and repetitive sequences in the human genome.) To this end, we formulate canonical problems that are representative of issues in reconstruction and are of small enough scale to be computationally tractable and simulatable. Using semi-realistic simulations, we show how we can combine different technologies to optimally solve the assembly at low cost. With mapability maps, our simulations efficiently handle the inhomogeneous repeat-containing structure of the human genome and the computational complexity of practical assembly algorithms. They quantitatively show how combining different read lengths is more cost-effective than using one length, how an optimal mixed sequencing strategy for reconstructing large novel SVs usually also gives accurate detection of SNPs/indels, how paired-end reads can improve reconstruction efficiency, and how adding in arrays is more efficient than just sequencing for disentangling some complex SVs. Our strategy should facilitate the sequencing of human genomes at maximum accuracy and low cost.');
INSERT INTO `Project2022_GenomicBD`.`Book` (`idBook`, `Title`, `Author`, `Description`) VALUES (3, 'Computational pan-genomics: status, promises and challenges', 'Computational Pan-Genomics Consortium', 'Many disciplines, from human genetics and oncology to plant breeding, microbiology and virology, commonly face the challenge of analyzing rapidly increasing numbers of genomes. In case of Homo sapiens, the number of sequenced genomes will approach hundreds of thousands in the next few years. Simply scaling up established bioinformatics pipelines will not be sufficient for leveraging the full potential of such rich genomic data sets. Instead, novel, qualitatively different computational methods and paradigms are needed. We will witness the rapid extension of computational pan-genomics, a new sub-area of research in computational biology. In this article, we generalize existing definitions and understand a pan-genome as any collection of genomic sequences to be analyzed jointly or to be used as a reference. We examine already available approaches to construct and use pan-genomes, discuss the potential benefits of future technologies and methodologies and review open challenges from the vantage point of the above-mentioned biological disciplines. As a prominent example for a computational paradigm shift, we particularly highlight the transition from the representation of reference genomes as strings to representations as graphs. We outline how this and other challenges from different application domains translate into common computational problems, point out relevant bioinformatics techniques and identify open problems in computer science. With this review, we aim to increase awareness that a joint approach to computational pan-genomics can help address many of the problems currently faced in various domains.');
INSERT INTO `Project2022_GenomicBD`.`Book` (`idBook`, `Title`, `Author`, `Description`) VALUES (4, 'CRISPR-Cas systems for editing, regulating and targeting genomes', 'Jeffry D Sander, J Keith Joung', 'Targeted genome editing using engineered nucleases has rapidly gone from being a niche technology to a mainstream method used by many biological researchers. This widespread adoption has been largely fueled by the emergence of the clustered, regularly interspaced, short palindromic repeat (CRISPR) technology, an important new approach for generating RNA-guided nucleases, such as Cas9, with customizable specificities. Genome editing mediated by these nucleases has been used to rapidly, easily and efficiently modify endogenous genes in a wide variety of biomedically important cell types and in organisms that have traditionally been challenging to manipulate genetically. Furthermore, a modified version of the CRISPR-Cas9 system has been developed to recruit heterologous domains that can regulate endogenous gene expression or label specific genomic loci in living cells. Although the genome-wide specificities of CRISPR-Cas9 systems remain to be fully defined, the power of these systems to perform targeted, highly efficient alterations of genome sequence and gene expression will undoubtedly transform biological research and spur the development of novel molecular therapeutics for human disease.');
INSERT INTO `Project2022_GenomicBD`.`Book` (`idBook`, `Title`, `Author`, `Description`) VALUES (5, 'Further resolution of the house mouse (Mus musculus) phylogeny by integration over isolation-with-migration histories', 'Megan Phifer-Rixey, Bettina Harr, Jody Hey', 'The three main subspecies of house mice, Mus musculus castaneus, Mus musculus domesticus, and Mus musculus musculus, are estimated to have diverged ~ 350-500KYA. Resolution of the details of their evolutionary history is complicated by their relatively recent divergence, ongoing gene flow among the subspecies, and complex demographic histories. Previous studies have been limited to some extent by the number of loci surveyed and/or by the scope of the method used. Here, we apply a method (IMa3) that provides an estimate of a population phylogeny while allowing for complex histories of gene exchange.');
INSERT INTO `Project2022_GenomicBD`.`Book` (`idBook`, `Title`, `Author`, `Description`) VALUES (6, 'A novel canis lupus familiaris reference genome improves variant resolution for use in breed-specific GWAS', 'Robert A Player,  Ellen R Forsyth,  Kathleen J Verratti, David W Mohr, Alan F Scott, Christopher E Bradburne', 'Reference genome fidelity is critically important for genome wide association studies, yet most vary widely from the study population. A typical whole genome sequencing approach implies short-read technologies resulting in fragmented assemblies with regions of ambiguity. Further information is lost by economic necessity when genotyping populations, as lower resolution technologies such as genotyping arrays are commonly used. Here, we present a phased reference genome for Canis lupus familiaris using high molecular weight DNA-sequencing technologies. We tested wet laboratory and bioinformatic approaches to demonstrate a minimum workflow to generate the 2.4 gigabase genome for a Labrador Retriever. The de novo assembly required eight Oxford Nanopore R9.4 flowcells (∼23X depth) and running a 10X Genomics library on the equivalent of one lane of an Illumina NovaSeq S1 flowcell (∼88X depth), bringing the cost of generating a nearly complete reference genome to less than $10K (USD). Mapping of short-read data from 10 Labrador Retrievers against this reference resulted in 1% more aligned reads versus the current reference (CanFam3.1, P < 0.001), and a 15% reduction of variant calls, increasing the chance of identifying true, low-effect size variants in a genome-wide association studies. We believe that by incorporating the cost to produce a full genome assembly into any large-scale genotyping project, an investigator can improve study power, decrease costs, and optimize the overall scientific value of their study.');
INSERT INTO `Project2022_GenomicBD`.`Book` (`idBook`, `Title`, `Author`, `Description`) VALUES (7, 'Chromosome-length genome assembly and structural variations of the primal Basenji dog (Canis lupus familiaris) genome', 'Richard J Edwards, Matt A Field, James M Ferguson, Olga Dudchenko, Jens Keilwagen, Benjamin D Rosen, Gary S Johnson, Edward S Rice, La Deanna Hillier, Jillian M Hammond, Samuel G Towarnicki, Arina Omer, Ruqayya Khan, Ksenia Skvortsova, Ozren Bogdanovic, Robert A Zammit, Erez Lieberman Aiden, Wesley C Warren, J William O Ballard', 'Basenjis are considered an ancient dog breed of central African origins that still live and hunt with tribesmen in the African Congo. Nicknamed the barkless dog, Basenjis possess unique phylogeny, geographical origins and traits, making their genome structure of great interest. The increasing number of available canid reference genomes allows us to examine the impact the choice of reference genome makes with regard to reference genome quality and breed relatedness.');
INSERT INTO `Project2022_GenomicBD`.`Book` (`idBook`, `Title`, `Author`, `Description`) VALUES (8, 'A whole-genome assembly of the domestic cow, Bos taurus', 'Aleksey V Zimin, Arthur L Delcher, Liliana Florea, David R Kelley, Michael C Schatz, Daniela Puiu, Finnian Hanrahan, Geo Pertea, Curtis P Van Tassell, Tad S Sonstegard, Guillaume Marçais, Michael Roberts, Poorani Subramanian, James A Yorke, Steven L Salzberg', 'The genome of the domestic cow, Bos taurus, was sequenced using a mixture of hierarchical and whole-genome shotgun sequencing methods.');
INSERT INTO `Project2022_GenomicBD`.`Book` (`idBook`, `Title`, `Author`, `Description`) VALUES (9, 'Whole-genome resequencing of wild and domestic sheep identifies genes associated with morphological and agronomic traits', 'Xin Li, Ji Yang , Min Shen, Xing-Long Xie, Guang-Jian Liu, Ya-Xi Xu, Feng-Hua Lv, Hua Yang, Yong-Lin Yang, Chang-Bin Liu, Ping Zhou, Peng-Cheng Wan, Yun-Sheng Zhang, Lei Gao, Jing-Quan Yang , Wen-Hui Pi, Yan-Ling Ren, Zhi-Qiang Shen, Feng Wang, Juan Deng,  Song-Song Xu, Hosein Salehian-Dehkordi, Eer Hehua, Ali Esmailizadeh, Mostafa Dehghani-Qanatqestani ', 'Understanding the genetic changes underlying phenotypic variation in sheep (Ovis aries) may facilitate our efforts towards further improvement. Here, we report the deep resequencing of 248 sheep including the wild ancestor (O. orientalis), landraces, and improved breeds. We explored the sheep variome and selection signatures. We detected genomic regions harboring genes associated with distinct morphological and agronomic traits, which may be past and potential future targets of domestication, breeding, and selection. Furthermore, we found non-synonymous mutations in a set of plausible candidate genes and significant differences in their allele frequency distributions across breeds. We identified PDGFD as a likely causal gene for fat deposition in the tails of sheep through transcriptome, RT-PCR, qPCR, and Western blot analyses. Our results provide insights into the demographic history of sheep and a valuable genomic resource for future genetic studies and improved genome-assisted breeding of sheep and other domestic animals.');
INSERT INTO `Project2022_GenomicBD`.`Book` (`idBook`, `Title`, `Author`, `Description`) VALUES (10, 'Genome-wide association study and inbreeding depression on body size traits in Qira black sheep (Ovis aries)', 'L Tao, Y F Liu, H Zhang, H Z Li, F P Zhao, F Y Wang, R S Zhang, R Di, M X Chu', 'Qira black sheep is a famous indigenous sheep breed in China. The objectives of this study are to identify candidate genes related to body size, and to estimate the level of inbreeding depression on body size based on runs of homozygosity in Qira black sheep. Here, 188 adult Qira black sheep were genotyped with a high density (630 K) SNP chip and genome-wide association study for body weight and body size traits (including withers height, body slanting length, tail length, chest girth, chest width, and chest depth) were performed using an additive linear model. In consequence, 12 genome- and chromosome-wide significant SNPs and, accordingly, six candidate genes involved in muscle differentiation, metabolism and cell processes were identified. Of them, ZNF704 (zinc finger protein 704) was identified for body weight; AK2 (adenylate kinase 2) and PARK2 (parkin RBR E3 ubiquitin protein ligase) for tail length; MOCOS (molybdenum cofactor sulfurase) and ELP2 (elongator acetyltransferase complex subunit 2) for chest width; and MFAP1 (microfibril associated protein 1) for chest girth. Additionally, inbreeding depressions on body size were observed in the current herd. These results will provide insightful understandings into the genetic mechanisms of adult body size, and into the conservation and utilization of Qira black sheep.');
INSERT INTO `Project2022_GenomicBD`.`Book` (`idBook`, `Title`, `Author`, `Description`) VALUES (11, 'The Drosophila melanogaster genome', 'Susan E Celniker, Gerald M Rubin', 'Drosophila\'s importance as a model organism made it an obvious choice to be among the first genomes sequenced, and the Release 1 sequence of the euchromatic portion of the genome was published in March 2000. This accomplishment demonstrated that a whole genome shotgun (WGS) strategy could produce a reliable metazoan genome sequence. Despite the attention to sequencing methods, the nucleotide sequence is just the starting point for genome-wide analyses; at a minimum, the genome sequence must be interpreted using expressed sequence tag (EST) and complementary DNA (cDNA) evidence and computational tools to identify genes and predict the structures of their RNA and protein products. The functions of these products and the manner in which their expression and activities are controlled must then be assessed-a much more challenging task with no clear endpoint that requires a wide variety of experimental and computational methods. We first review the current state of the Drosophila melanogaster genome sequence and its structural annotation and then briefly summarize some promising approaches that are being taken to achieve an initial functional annotation.');
INSERT INTO `Project2022_GenomicBD`.`Book` (`idBook`, `Title`, `Author`, `Description`) VALUES (12, 'Genome-wide RNAi screening in Caenorhabditis elegans', 'Ravi S Kamath, Julie Ahringer', 'In Caenorhabditis elegans, introduction of double-stranded RNA (dsRNA) results in the specific inactivation of an endogenous gene with corresponding sequence; this technique is known as RNA interference (RNAi). It has previously been shown that RNAi can be performed by direct microinjection of dsRNA into adult hermaphrodite worms, by soaking worms in a solution of dsRNA, or by feeding worms Escherichia coli expressing target-gene dsRNA. We have developed a simple optimized protocol exploiting this third mode of dsRNA introduction, RNAi by feeding, which allows rapid and effective analysis of gene function in C. elegans. Furthermore, we have constructed a library of bacterial strains corresponding to roughly 86% of the estimated 19,000 predicted genes in C. elegans, and we have used it to perform genome-wide analyses of gene function. This library is publicly available, reusable resource allowing for rapid large-scale RNAi experiments. We have used this library to perform genome-wide analyses of gene function in C. elegans. Here, we describe the protocols used for bacterial library construction and for high-throughput screening in C. elegans using RNAi by feeding.');
INSERT INTO `Project2022_GenomicBD`.`Book` (`idBook`, `Title`, `Author`, `Description`) VALUES (13, 'CRISPR-Cas9 mediated genome editing in Caenorhabditis elegans', 'Xi\'nan Meng, Hengda Zhou, Suhong Xu', 'The development of genome editing techniques based on CRISPR (Clustered regularly interspaced short palindromic repeats)-Cas9 system has revolutionized biomedical researches. It can be utilized to edit genome sequence in almost any organisms including Caenorhabditis elegans, one of the most convenient and classic genetic model animals. The application of CRISPR-Cas9 mediated genome editing in C. elegans promotes the functional analysis of gene and proteins under many physiological conditions. In this mini-review, we summarized the development of CRISPR-Cas9-based genome editing in C. elegans.');
INSERT INTO `Project2022_GenomicBD`.`Book` (`idBook`, `Title`, `Author`, `Description`) VALUES (14, 'Transgenesis in zebrafish with the tol2 transposon system', 'Maximiliano L Suster, Hiroshi Kikuta, Akihiro Urasaki, Kazuhide Asakawa, Koichi Kawakami', 'The zebrafish (Danio rerio) is a useful model for genetic studies of vertebrate development. Its embryos are transparent and develop rapidly outside the mother, making it feasible to visualize and manipulate specific cell types in the living animal. Zebrafish is well suited for transgenic manipulation since it is relatively easy to collect large numbers of embryos from adult fish. Several approaches have been developed for introducing transgenes into the zebrafish germline, from the injection of naked DNA to transposon-mediated integration. In particular, the Tol2 transposable element has been shown to create insertions in the zebrafish genome very efficiently. By using Tol2, gene trap and enhancer trap vectors containing the GFP reporter gene or yeast transcription activator Gal4 gene have been developed. Here we outline methodology for creating transgenic zebrafish using Tol2 vectors, and their applications to visualization and manipulation of specific tissues or cells in vivo and for functional studies of vertebrate neural circuits.');
INSERT INTO `Project2022_GenomicBD`.`Book` (`idBook`, `Title`, `Author`, `Description`) VALUES (15, 'Arabidopsis thaliana: a model plant for genome analysis', 'D W Meinke, J M Cherry, C Dean, S D Rounsley, M Koornneef', 'Arabidopsis thaliana is a small plant in the mustard family that has become the model system of choice for research in plant biology. Significant advances in understanding plant growth and development have been made by focusing on the molecular genetics of this simple angiosperm. The 120-megabase genome of Arabidopsis is organized into five chromosomes and contains an estimated 20,000 genes. More than 30 megabases of annotated genomic sequence has already been deposited in GenBank by a consortium of laboratories in Europe, Japan, and the United States. The entire genome is scheduled to be sequenced by the end of the year 2000. Reaching this milestone should enhance the value of Arabidopsis as a model for plant biology and the analysis of complex organisms in general.');
INSERT INTO `Project2022_GenomicBD`.`Book` (`idBook`, `Title`, `Author`, `Description`) VALUES (16, 'Functions of long non-coding RNA in Arabidopsis thaliana', 'Preethi Jampala, Akanksha Garhewal, Mukesh Lodha', 'A major part of the eukaryotic genome is transcribed into non-coding RNAs (ncRNAs) having no protein coding potential. ncRNAs which are longer than 200 nucleotides are categorized as long non coding RNAs (lncRNAs). Most lncRNAs are induced as a consequence of various environmental and developmental cues. Among plants, the functions of lncRNAs are best studied in Arabidopsis thaliana. In this review, we highlight the important functional roles of various lncRNAs during different stages of Arabidopsis life cycle and their response to environmental changes. These lncRNAs primarily govern processes such as flowering, seed germination, stress response, light- and auxin-regulated development, and RNA-dependent DNA methylation (RdDM). Major challenge is to differentiate between functional and cryptic transcripts. Genome editing, large scale RNAi and computational approaches may help to identify and characterize novel functional lncRNAs in Arabidopsis.');
INSERT INTO `Project2022_GenomicBD`.`Book` (`idBook`, `Title`, `Author`, `Description`) VALUES (17, 'Improvement of the Oryza sativa Nipponbare reference genome using next generation sequence and optical map data', 'Yoshihiro Kawahara, Melissa de la Bastide, John P Hamilton, Hiroyuki Kanamori, W Richard McCombie, Shu Ouyang, David C Schwartz, Tsuyoshi Tanaka, Jianzhong Wu, Shiguo Zhou, Kevin L Childs, Rebecca M Davidson, Haining Lin, Lina Quesada-Ocampo, Brieanne Vaillancourt, Hiroaki Sakai, Sung Shin Lee, Jungsok Kim, Hisataka Numa, Takeshi Itoh, C Robin Buell, Takashi Matsumoto', 'Rice research has been enabled by access to the high quality reference genome sequence generated in 2005 by the International Rice Genome Sequencing Project (IRGSP). To further facilitate genomic-enabled research, we have updated and validated the genome assembly and sequence for the Nipponbare cultivar of Oryza sativa (japonica group).');

COMMIT;


-- -----------------------------------------------------
-- Data for table `Project2022_GenomicBD`.`Bookshelf`
-- -----------------------------------------------------
START TRANSACTION;
USE `Project2022_GenomicBD`;
INSERT INTO `Project2022_GenomicBD`.`Bookshelf` (`Genome_idGenome`, `Book_idBook`) VALUES (1, 1);
INSERT INTO `Project2022_GenomicBD`.`Bookshelf` (`Genome_idGenome`, `Book_idBook`) VALUES (1, 2);
INSERT INTO `Project2022_GenomicBD`.`Bookshelf` (`Genome_idGenome`, `Book_idBook`) VALUES (1, 3);
INSERT INTO `Project2022_GenomicBD`.`Bookshelf` (`Genome_idGenome`, `Book_idBook`) VALUES (2, 4);
INSERT INTO `Project2022_GenomicBD`.`Bookshelf` (`Genome_idGenome`, `Book_idBook`) VALUES (2, 5);
INSERT INTO `Project2022_GenomicBD`.`Bookshelf` (`Genome_idGenome`, `Book_idBook`) VALUES (3, 6);
INSERT INTO `Project2022_GenomicBD`.`Bookshelf` (`Genome_idGenome`, `Book_idBook`) VALUES (3, 7);
INSERT INTO `Project2022_GenomicBD`.`Bookshelf` (`Genome_idGenome`, `Book_idBook`) VALUES (4, 8);
INSERT INTO `Project2022_GenomicBD`.`Bookshelf` (`Genome_idGenome`, `Book_idBook`) VALUES (5, 9);
INSERT INTO `Project2022_GenomicBD`.`Bookshelf` (`Genome_idGenome`, `Book_idBook`) VALUES (5, 10);
INSERT INTO `Project2022_GenomicBD`.`Bookshelf` (`Genome_idGenome`, `Book_idBook`) VALUES (6, 11);
INSERT INTO `Project2022_GenomicBD`.`Bookshelf` (`Genome_idGenome`, `Book_idBook`) VALUES (7, 12);
INSERT INTO `Project2022_GenomicBD`.`Bookshelf` (`Genome_idGenome`, `Book_idBook`) VALUES (7, 13);
INSERT INTO `Project2022_GenomicBD`.`Bookshelf` (`Genome_idGenome`, `Book_idBook`) VALUES (8, 15);
INSERT INTO `Project2022_GenomicBD`.`Bookshelf` (`Genome_idGenome`, `Book_idBook`) VALUES (8, 16);
INSERT INTO `Project2022_GenomicBD`.`Bookshelf` (`Genome_idGenome`, `Book_idBook`) VALUES (9, 14);
INSERT INTO `Project2022_GenomicBD`.`Bookshelf` (`Genome_idGenome`, `Book_idBook`) VALUES (10, 17);

COMMIT;

