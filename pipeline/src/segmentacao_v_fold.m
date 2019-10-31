function segmentacao_v_fold(features)

p = 0:10;

percent = 0.999999;

fprintf('Realizando teste v-fold\n');

for medico=1:2
    fprintf('--- Medico: %d ---\n',medico);
    for paciente=0:10
        fprintf('Teste: paciente%d\n',paciente);
        pacientes = p(p ~= paciente);
        model = segmentacao_treina_svm(pacientes,features,percent,medico);
        segmentacao_testa_svm(model,paciente,features,medico);
    end
end